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
    var players: [Person]
    
    init() {
        self.rounds = []
        self.players = []
    }
    
    init(rounds: [MolkkyRound], players: [Person]) {
        self.rounds = rounds
        self.players = players
    }
    
    mutating func addPlayers(_ newPlayers: [Person]) {
        newPlayers.forEach { newPlayer in
            if (!players.contains(where: {$0.id == newPlayer.id})) {
                players.append(newPlayer)
            }
        }
    }
    
    mutating func addRound(_ round: MolkkyRound) {
        rounds.append(round)
    }
}

extension SkittleData {
    static let sampleData: SkittleData = SkittleData()
}
