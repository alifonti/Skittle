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
    
    // - Game Preferences
    var targetScore: Int = 50
    var canBeEliminated: Bool = true
    var missesForElimination: Int = 3
    var canBeReset: Bool = true
    var resetScore: Int = 25
    
    var resetInsteadOfEliminate: Bool = false
    var canExceedTarget: Bool = false
    var continueUntilAllFinished: Bool = false
    var allPlayersGetEqualThrows: Bool = false
    
    // - Animation State
    var wasAttemptAdded = true
    
    // - Settings
    var sortByTurn: Bool = true
    
    // --- Calculated Values
    var hasGameEnded: Bool {
        contenderScores.lazy.filter({ $0.isFinished }).count >= contenderScores.count - 1
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
            scoreDict.updateValue(calculateTotalScore(total: scoreDict[attempt.contender, default: 0], nextScore: attempt.score), forKey: attempt.contender)
            if (scoreDict[attempt.contender] == targetScore) {
                finishPositions.append(attempt.contender)
            }
        }
        
        var results = dict.map {
            ContenderScore(
                player: $0.key,
                attempts: $0.value,
                totalScore: scoreDict[$0.key] ?? 0,
                isInWarning: $0.value.count >= (missesForElimination - 1) && $0.value.suffix((missesForElimination - 1)).allSatisfy({$0.score == 0}),
                isEliminated: $0.value.count >= (missesForElimination) && $0.value.suffix((missesForElimination)).allSatisfy({$0.score == 0}),
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
            let nps = contenderScores.first(where: {$0.contender == player})
            if let nps {
                return (!nps.isFinished)
            }
            return false
        })
        if (activePlayers.count >= 1 + offset) {
            return activePlayers[(0 + offset) % activePlayers.count]
        } else {
            return nil
        }
    }
    
    func calculateTotalScore(total: Int, nextScore: Int) -> Int {
        let nextTotal = total + nextScore
        if (nextTotal <= targetScore) {
            return nextTotal
        } else if (total == targetScore) {
            return total
        } else {
            return canBeReset ? resetScore : total
        }
    }
    
//    func getResults() {
//        for attempt in attempts {
//            //
//        }
//    }
    
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
}

extension MolkkyRound {
    static let sampleData: MolkkyRound = MolkkyRound(players: Player.sampleData)
}
