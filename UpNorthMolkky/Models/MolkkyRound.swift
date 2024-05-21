//
//  MolkkyRound.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/13/23.
//

import Foundation

struct MolkkyRound: Identifiable, Codable, Hashable {
    let id: UUID
    let date: Date
    
    // -
    var contenders: [Contender] = []
    
    // - Game Data
    var attempts: [ContenderAttempt] = []
    var undoStack: [ContenderAttempt] = []
    var currentContenderIndex: Int = 0
    var endedEarly: Bool = false
    
    // - Game Preferences
    var targetScore: Int = 50
    var canBeEliminated: Bool = true
    var missesForElimination: Int = 3
    var canBeReset: Bool = true
    var resetScore: Int = 25
    
    var resetInsteadOfEliminate: Bool = false
    var canExceedTarget: Bool = false
    var continueUntilAllFinished: Bool = false
    var allPlayersGetEqualThrows: Bool = false // TODO later
    var maxRounds: Int = 10 // TODO later
    
    // - Animation State
    var wasAttemptAdded = true
    
    // - Settings
    var sortByTurn: Bool = true
    
    // --- Calculated Values
    var hasGameEnded: Bool {
        endedEarly ||
        contenderScores.filter({ $0.isFinished }).count >= contenderScores.count - 1 ||
        (!continueUntilAllFinished && contenderScores.filter({ $0.finishPosition >= 0 }).count == 1)
    }
    
    var currentContender: Contender {
        contenders[currentContenderIndex]
    }
    var currentContenderScore: MolkkyRound.ContenderScore? {
        contenderScores.first(where: {$0.contender == currentContender})
    }
    
    var contenderScores: [ContenderScore] {
        var dict: [Contender: [ContenderAttempt]] = Dictionary(uniqueKeysWithValues: contenders.map { ($0, [])})
        var scoreDict: [Contender: Int] = Dictionary(uniqueKeysWithValues: contenders.map { ($0, 0)})
        var finishPositions: [Contender] = []
        
        for attempt in attempts {
            dict.updateValue(dict[attempt.contender, default: []] + [attempt], forKey: attempt.contender)
            
            let attempts = dict[attempt.contender, default: []]            
            let shouldBeEliminated = attempts.count >= (missesForElimination) && attempts.suffix(missesForElimination).allSatisfy({$0.score == 0})
            let nextScore = calculateTotalScore(total: scoreDict[attempt.contender, default: 0],
                                                nextScore: attempt.score,
                                                shouldBeEliminated: shouldBeEliminated)
            
            scoreDict.updateValue(nextScore, forKey: attempt.contender)
            if (scoreDict[attempt.contender] == targetScore) {
                finishPositions.append(attempt.contender)
            }
        }
        
        var results = dict.map {
            ContenderScore(
                player: $0.key,
                attempts: $0.value,
                totalScore: scoreDict[$0.key] ?? 0,
                isInWarning: (canBeEliminated || resetInsteadOfEliminate) &&
                    $0.value.count >= (missesForElimination - 1) &&
                    ($0.value.suffix(from: ($0.value.lastIndex(where: { $0.score != 0 }) ?? -1) + 1 ).count % missesForElimination) == missesForElimination - 1,
                isEliminated: (canBeEliminated && !resetInsteadOfEliminate) &&
                    $0.value.count >= (missesForElimination) &&
                    $0.value.suffix((missesForElimination)).allSatisfy({$0.score == 0}),
                finishPosition: finishPositions.firstIndex(of: $0.key) ?? -1
            )
        }
        
        if (sortByTurn) {
            results.sort { $0.contender.orderKey < $1.contender.orderKey }
        } else {
            results.sort { (lhs, rhs) in
                let predicates: [(ContenderScore, ContenderScore) -> Bool] = [
                    { !$0.isEliminated && $1.isEliminated },
                    { $0.totalScore > $1.totalScore },
                    { $0.finishPosition < $1.finishPosition },
                    { $0.contender.orderKey < $1.contender.orderKey }
                ]
                for predicate in predicates {
                    if !predicate(lhs, rhs) && !predicate(rhs, lhs) {
                        continue
                    }
                    return predicate(lhs, rhs)
                }
                return false
            }
        }
        
        return results
    }
    
    // --- Mutating Functions
    mutating func recordAttempt(attempt: MolkkyRound.ContenderAttempt) {
        attempts.append(attempt)
        wasAttemptAdded = true
        advanceToNextContender()
    }
    
    mutating func advanceToNextContender() {
        let nextPlayer = findNextContender()
        if let nextPlayer {
            let indexOfNextPlayer = contenders.firstIndex(of: nextPlayer)
            if let indexOfNextPlayer {
                currentContenderIndex = indexOfNextPlayer % contenders.count
            }
        } else {
            print("end game?")
        }
    }
    
    mutating func undo() {
        if (attempts.count > 0) {
            let lastAttempt = attempts.popLast()
            if let lastAttempt {
                undoStack.append(lastAttempt)
                wasAttemptAdded = false // TODO: refactor
                let index = contenders.firstIndex(of: lastAttempt.contender)
                if let index {
                    currentContenderIndex = index
                }
            }
        }
    }
    
    mutating func redo() {
        if (undoStack.count > 0) {
            let lastUndoAttempt = undoStack.popLast()
            if let lastUndoAttempt {
                recordAttempt(attempt: lastUndoAttempt)
            }
        }
    }
    
    mutating func toggleSort() {
        sortByTurn = !sortByTurn
    }
    
    mutating func clearUndoStack() {
        undoStack.removeAll()
    }
    
    mutating func updateWasAttemptAdded(value: Bool) {
        wasAttemptAdded = value
    }
    
    // --- Helper Functions
    func findNextContender(_ offset: Int = 0) -> Contender? {
        let followingPlayers = contenders[(currentContenderIndex + 1)...] + contenders[...(currentContenderIndex)]
        let activePlayers = followingPlayers.filter({ player in
            let nextPlayersScore = contenderScores.first(where: {$0.contender == player})
            if let nextPlayersScore {
                return (!nextPlayersScore.isFinished)
            }
            return false
        })
        if (activePlayers.count >= 1 + offset) {
            return activePlayers[(0 + offset) % activePlayers.count]
        } else {
            return nil
        }
    }
    
    func calculateTotalScore(total: Int, nextScore: Int, shouldBeEliminated: Bool) -> Int {
        if (shouldBeEliminated && resetInsteadOfEliminate) {
            return 0
        }
        
        let nextTotal = total + nextScore
        if (nextTotal <= targetScore) {
            return nextTotal
        } else if (canBeReset) {
            return resetScore
        } else {
            return total
        }
    }
    
    static func getSortedResults(round: MolkkyRound) -> [(UUID, MolkkyRound.ContenderScore, Int)] {
        var array: [(UUID, MolkkyRound.ContenderScore, Int)] = []
        
        let sorted = round.contenderScores.sorted { (lhs, rhs) in
            let predicates: [(MolkkyRound.ContenderScore, MolkkyRound.ContenderScore) -> Bool] = [
                { !$0.isEliminated && $1.isEliminated },
                { $0.totalScore > $1.totalScore },
                { $0.finishPosition < $1.finishPosition },
                { $0.contender.orderKey < $1.contender.orderKey }
            ]
            for predicate in predicates {
                if !predicate(lhs, rhs) && !predicate(rhs, lhs) {
                    continue
                }
                return predicate(lhs, rhs)
            }
            return false
        }
        
        var lastScore: Int = -1
        var lastScoreIndex: Int = 0
        
        for (index, element) in sorted.enumerated() {
            if element.finishPosition >= 0 {
                array.append((UUID(), element, element.finishPosition + 1))
            } else if (element.totalScore != lastScore) {
                array.append((UUID(), element, index + 1))
                lastScore = element.totalScore
                lastScoreIndex = index
            } else {
                array.append((UUID(), element, lastScoreIndex + 1))
            }
        }
        
        return array
    }
    
    static func getPlayerAwards(round: MolkkyRound) -> [(Award, [Contender], String?)] {
        // Use new "Player" (that extends Contender) instead
        var awards: [(Award, [Contender], String?)] = []
        
        var twelvesDict: [Contender: Int] = [:]
        var onesDict: [Contender: Int] = [:]
        var zeroesDict: [Contender: Int] = [:]
        var numbersDict: [Contender: Set<Int>] = [:]
        
        round.attempts.forEach { attempt in
            if (attempt.score == 12) {
                twelvesDict.updateValue((twelvesDict[attempt.contender] ?? 0) + 1, forKey: attempt.contender)
            } else if (attempt.score == 1) {
                onesDict.updateValue((onesDict[attempt.contender] ?? 0) + 1, forKey: attempt.contender)
            } else if (attempt.score == 0) {
                zeroesDict.updateValue((zeroesDict[attempt.contender] ?? 0) + 1, forKey: attempt.contender)
            }
            
            if (!(attempt.score == 0)) {
                var numberSet = numbersDict[attempt.contender] ?? Set<Int>()
                numberSet.insert(attempt.score)
                numbersDict.updateValue(numberSet, forKey: attempt.contender)
            }
        }
        
        // Maximalist
        if let maximalistData = MolkkyRound.getMost(dict: twelvesDict) {
            awards.append((Award.maximalist, maximalistData.0, String(maximalistData.1)))
        }
        // Minimalist
        if let minimalistData = MolkkyRound.getMost(dict: onesDict) {
            awards.append((Award.minimalist, minimalistData.0, String(minimalistData.1)))
        }
        // Unlucky
        if let unluckyData = MolkkyRound.getMost(dict: zeroesDict) {
            awards.append((Award.unlucky, unluckyData.0, String(unluckyData.1)))
        }
        // Spotless
        let spotlessData = round.contenders.filter({zeroesDict[$0] == nil})
        if (spotlessData.count > 0) {
            awards.append((Award.spotless, Array(spotlessData), nil))
        }
        // Reckless + Efficient
        var recklessDict: [Contender: Int] = [:]
        var efficientData: [(Contender, Double)] = []
        round.contenderScores.forEach({
            var resetCount = 0
            var scoreAccum = 0
            var efficiencyTotal = 0
            var runningMissTotal = 0
            $0.attempts.map({$0.score}).forEach({
                if ($0 == 0) {
                    runningMissTotal += 1
                    if (round.resetInsteadOfEliminate && runningMissTotal == round.missesForElimination) {
                        scoreAccum = 0
                        runningMissTotal = 0
                    }
                } else {
                    runningMissTotal = 0
                }
                if (scoreAccum + $0 > round.targetScore) {
                    resetCount += 1
                    scoreAccum = round.resetScore
                } else {
                    scoreAccum += $0
                    efficiencyTotal += $0
                }
            })
            if (resetCount > 0) {
                recklessDict.updateValue(resetCount, forKey: $0.contender)
            }
            efficientData.append(($0.contender, (Double(efficiencyTotal) / Double($0.attempts.count))))
        })
        // Reckless
        if let recklessData = MolkkyRound.getMost(dict: recklessDict) {
            awards.append((Award.reckless, recklessData.0, String(recklessData.1)))
        }
        // Efficient
        let sortedEfficientData: [(Contender, Double)] = efficientData
            .sorted(by: { $0.1 > $1.1 })
        let filteredEfficientData: [(Contender, Double)] = sortedEfficientData
            .filter({$0.1 == sortedEfficientData.first?.1 ?? -1})
        if (filteredEfficientData.count > 0) {
            awards.append((Award.efficient, filteredEfficientData.map({$0.0}), String(format: "%.2f", filteredEfficientData[0].1)))
        }
        // Survivor
        var survivorData: [Contender] = []
        if (round.canBeEliminated && !round.resetInsteadOfEliminate) {
            round.contenderScores.forEach({
                let range = $0.attempts.map({$0.score}).firstRange(of: Array(repeating: 0, count: round.missesForElimination - 1))
                if (range != nil && range?.endIndex != $0.attempts.count && !$0.isEliminated) {
                    survivorData.append($0.contender)
                }
            })
        }
        if (survivorData.count > 0) {
            awards.append((Award.survivor, survivorData, nil))
        }
        // So close!
        let soCloseData = round.contenderScores.filter({$0.totalScore == round.targetScore - 1}).map({$0.contender})
        if (soCloseData.count > 0) {
            awards.append((Award.soClose, soCloseData, nil))
        }
        // Oops?
        let oopsData = round.contenderScores.filter({$0.totalScore == 0}).map({$0.contender})
        if (oopsData.count > 0) {
            awards.append((Award.oops, oopsData, nil))
        }
        // Selective, Variety, Rainbow
        if (numbersDict.count > 0) {
            var selectiveData: [Contender] = []
            var varietyData: [Contender] = []
            var rainbowData: [Contender] = []
            numbersDict.forEach({
                if ($0.value.count <= 3) {
                    selectiveData.append($0.key)
                } else if ($0.value.count >= 7 && $0.value.count <= 11) {
                    varietyData.append($0.key)
                } else if ($0.value.count == 12) {
                    rainbowData.append($0.key)
                }
            })
            if selectiveData.count > 0 {
                awards.append((Award.selective, selectiveData, nil))
            }
            if varietyData.count > 0 {
                awards.append((Award.variety, varietyData, nil))
            }
            if rainbowData.count > 0 {
                awards.append((Award.rainbow, rainbowData, nil))
            }
        }
        
        return awards
    }
    
    // --- Initializers
    init(id: UUID = UUID(), date: Date = Date.now, players: [Player]) {
        self.id = id
        self.date = Date.now
        self.contenders = players.enumerated().map { Contender(name: $1.playerName, orderKey: $0) }
    }
    
    init(id: UUID = UUID(), date: Date = Date.now, players: [Player], targetScore: Int, resetScore: Int, missesForElimination: Int) {
        self.id = id
        self.date = Date.now
        self.contenders = players.enumerated().map { Contender(name: $1.playerName, orderKey: $0) }
        self.targetScore = targetScore
        self.resetScore = resetScore
        self.missesForElimination = missesForElimination
    }
    
    init(id: UUID = UUID(), date: Date = Date.now, round: MolkkyRound) {
        self.id = id
        self.date = Date.now
        self.contenders = MolkkyRound.getSortedResults(round: round).reversed().enumerated().map {
            Contender(id: $1.1.contender.id, name: $1.1.contender.name, orderKey: $0)
        }
        self.targetScore = round.targetScore
        self.canBeEliminated = round.canBeEliminated
        self.missesForElimination = round.missesForElimination
        self.resetInsteadOfEliminate = round.resetInsteadOfEliminate
        self.canBeReset = round.canBeReset
        self.resetScore = round.resetScore
    }
}

extension MolkkyRound {
    struct ContenderScore: Identifiable, Codable {
        let id: UUID
        
        let contender: Contender
        let attempts: [ContenderAttempt]
        let totalScore: Int
        
        let isInWarning: Bool
        let isEliminated: Bool
        let finishPosition: Int
        var isFinished: Bool { finishPosition >= 0 || isEliminated}
        
        init(id: UUID = UUID(), player: Contender, attempts: [ContenderAttempt], totalScore: Int, isInWarning: Bool, isEliminated: Bool, finishPosition: Int) {
            self.id = id
            self.contender = player
            self.attempts = attempts
            self.totalScore = totalScore
            self.isInWarning = isInWarning
            self.isEliminated = isEliminated
            self.finishPosition = finishPosition
        }
    }
    
    struct ContenderAttempt: Identifiable, Codable, Hashable {
        let id: UUID
        
        let contender: Contender
        var score: Int = 0
        
        init(id: UUID = UUID(), player: Contender, score: Int) {
            self.id = id
            self.contender = player
            self.score = score
        }
    }
    
    static func getMost(dict: [Contender: Int]) -> ([Contender], Int)? {
        if (!dict.isEmpty) {
            let sorted = dict.sorted(by: { $0.1 > $1.1 })
            let filtered = sorted.filter({$0.value == sorted.first?.value ?? -1})
            return (filtered.map({$0.key}), filtered[0].value)
        } else {
            return nil
        }
    }
}

extension MolkkyRound {
    static let sampleData: MolkkyRound = MolkkyRound(players: Player.sampleData)
}
