import SwiftUI

@MainActor
class MolkkyStore: ObservableObject {
    @Published var userData: SkittleData = SkittleData()
    
    var clock = ContinuousClock()
    func logTime(duration: ContinuousClock.Duration, function: String = #function) {
        print("\(function) Time taken = \(duration)")
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("skittle.data")
    }
    
    func load() async throws {
        let task = Task<SkittleData, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return SkittleData()
            }
            let skittleData = try JSONDecoder().decode(SkittleData.self, from: data)
            return skittleData
        }
        let data = try await task.value
        self.userData = data
    }
    
    func save(data: SkittleData) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(data)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}

struct SkittleData: Codable {
    var rounds: [MolkkyRound]
    var players: [Player]
    
    init() {
        self.rounds = []
        self.players = []
    }
    
    init(rounds: [MolkkyRound], players: [Player]) {
        self.rounds = rounds
        self.players = players
    }
    
    mutating func addPlayers(_ newPlayers: [Player]) {
        newPlayers.forEach { newPlayer in
            if (!players.contains(where: {$0.id == newPlayer.id})) {
                players.append(newPlayer)
            }
        }
    }
    
    mutating func removePlayer(_ player: Player) {
        if let index = players.firstIndex(of: player) {
            players.remove(at: index)
        }
    }
    
    mutating func addRound(_ round: MolkkyRound) {
        rounds.append(round)
    }
    
    func getPlayerStats() -> [String: [UUID: any Numeric]] {
        var roundCountDict: [UUID: Int] = [:]
        var attemptDict: [UUID: [Int]] = [:]
        var winsDict: [UUID: Int] = [:]
        
        rounds.forEach { round in
            round.contenders.forEach { contender in
                roundCountDict.updateValue((roundCountDict[contender.id] ?? 0) + 1, forKey: contender.id)
                if (round.contenderScores.first(where: {score in score.contender.id == contender.id})?.finishPosition == 0) {
                    winsDict.updateValue((winsDict[contender.id] ?? 0) + 1, forKey: contender.id)
                }
            }
            round.attempts.forEach { attempt in
                attemptDict.updateValue((attemptDict[attempt.contender.id] ?? []) + [attempt.score], forKey: attempt.contender.id)
            }
        }
        
        let attemptCountDict: [UUID: Int] = attemptDict.mapValues { array in array.count }
        let attemptAverageDict: [UUID: Double] = attemptDict.mapValues { array in Double(array.reduce(0, { x, y in x + y })) / Double(array.count) }
        
        return ["RoundCount": roundCountDict, "AttemptCount": attemptCountDict, "AttemptAverage": attemptAverageDict, "WinCount": winsDict]
    }
    
    func getPlayerAwards() -> [UUID: [Award: Int]] {
        var awardsDict: [UUID: [Award: Int]] = [:]
        
        rounds.forEach { round in
            if (round.hasGameEnded) {
                let awards: [(Award, [Contender], String?)] = MolkkyRound.getPlayerAwards(round: round)
                awards.forEach { award in
                    award.1.forEach { contender in
                        var playerDict = awardsDict[contender.id, default: [:]]
                        playerDict.updateValue(playerDict[award.0, default: 0] + 1, forKey: award.0)
                        awardsDict.updateValue(playerDict, forKey: contender.id)
                    }
                }
            }
        }
        
        return awardsDict
    }
    
    func getGeneralStats() -> [String: Int] {
        var attemptTotal: Int = 0
        var awardsTotal: Int = 0
        
        rounds.forEach { round in
            attemptTotal += round.attempts.count
            
            if (round.hasGameEnded) {
                let awards: [(Award, [Contender], String?)] = MolkkyRound.getPlayerAwards(round: round)
                awards.forEach { award in
                    awardsTotal += award.1.count
                }
            }
        }
        
        return ["RoundCount": rounds.count, "PlayerCount": players.count, "ThrowCount": attemptTotal, "AwardCount": awardsTotal]
    }
}

extension SkittleData {
    static let sampleData: SkittleData = SkittleData(rounds: [], players: [Player(playerName: "Anthony"), Player(playerName: "Emma")])
}
