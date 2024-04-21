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
    var players: [Player] = []
    
    // - Game Data
    var attempts: [PlayerAttempt] = []
    var undoStack: [PlayerAttempt] = []
    var currentPlayerIndex: Int = 0
    
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
        playerScores.lazy.filter({ $0.isFinished }).count >= playerScores.count - 1
    }
    
    var currentPlayer: Player {
        players[currentPlayerIndex]
    }
    var currentPlayerScore: MolkkyRound.PlayerScore? {
        playerScores.first(where: {$0.player == currentPlayer})
    }
    
    var playerScores: [PlayerScore] {
        var dict: [Player: [PlayerAttempt]] = Dictionary(uniqueKeysWithValues: players.map { ($0, [])})
        var scoreDict: [Player: Int] = Dictionary(uniqueKeysWithValues: players.map { ($0, 0)})
        var finishPositions: [Player] = []
        
        for attempt in attempts {
            dict.updateValue(dict[attempt.player, default: []] + [attempt], forKey: attempt.player)
            scoreDict.updateValue(calculateTotalScore(total: scoreDict[attempt.player, default: 0], nextScore: attempt.score), forKey: attempt.player)
            if (scoreDict[attempt.player] == targetScore) {
                finishPositions.append(attempt.player)
            }
        }
        
        var results = dict.map {
            PlayerScore(
                player: $0.key,
                attempts: $0.value,
                totalScore: scoreDict[$0.key] ?? 0,
                isInWarning: $0.value.count >= (missesForElimination - 1) && $0.value.suffix((missesForElimination - 1)).allSatisfy({$0.score == 0}),
                isEliminated: $0.value.count >= (missesForElimination) && $0.value.suffix((missesForElimination)).allSatisfy({$0.score == 0}),
                finishPosition: finishPositions.firstIndex(of: $0.key) ?? -1
            )
        }
        
        if (sortByTurn) {
            results.sort { $0.player.orderKey < $1.player.orderKey }
        } else {
            results.sort { (lhs, rhs) in
                let predicates: [(PlayerScore, PlayerScore) -> Bool] = [
                    { !$0.isEliminated && $1.isEliminated },
                    { $0.totalScore > $1.totalScore },
                    { $0.finishPosition < $1.finishPosition },
                    { $0.player.orderKey < $1.player.orderKey }
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
    mutating func recordAttempt(attempt: MolkkyRound.PlayerAttempt) {
        attempts.append(attempt)
        wasAttemptAdded = true
        advanceToNextPlayer()
    }
    
    mutating func advanceToNextPlayer() {
        let nextPlayer = findNextPlayer()
        if let nextPlayer {
            let indexOfNextPlayer = players.firstIndex(of: nextPlayer)
            if let indexOfNextPlayer {
                currentPlayerIndex = indexOfNextPlayer % players.count
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
                let index = players.firstIndex(of: lastAttempt.player)
                if let index {
                    currentPlayerIndex = index
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
    func findNextPlayer(_ offset: Int = 0) -> Player? {
        let followingPlayers = players[(currentPlayerIndex + 1)...] + players[...(currentPlayerIndex)]
        let activePlayers = followingPlayers.filter({ player in
            let nps = playerScores.first(where: {$0.player == player})
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
    init(id: UUID = UUID(), date: Date = Date.now, players: [Person]) {
        self.id = id
        self.date = Date.now
        self.players = players.enumerated().map { Player(playerName: $1.playerName, orderKey: $0) }
    }
    
    init(id: UUID = UUID(), date: Date = Date.now, players: [Person], targetScore: Int, resetScore: Int, missesForElimination: Int) {
        self.id = id
        self.date = Date.now
        self.players = players.enumerated().map { Player(playerName: $1.playerName, orderKey: $0) }
        self.targetScore = targetScore
        self.resetScore = resetScore
        self.missesForElimination = missesForElimination
    }
}

extension MolkkyRound {
    struct PlayerScore: Identifiable, Codable {
        let id: UUID
        
        let player: Player
        let attempts: [PlayerAttempt]
        let totalScore: Int
        
        let isInWarning: Bool
        let isEliminated: Bool
        let finishPosition: Int
        var isFinished: Bool { finishPosition >= 0 || isEliminated}
        
        init(id: UUID = UUID(), player: Player, attempts: [PlayerAttempt], totalScore: Int, isInWarning: Bool, isEliminated: Bool, finishPosition: Int) {
            self.id = id
            self.player = player
            self.attempts = attempts
            self.totalScore = totalScore
            self.isInWarning = isInWarning
            self.isEliminated = isEliminated
            self.finishPosition = finishPosition
        }
    }
    
    struct PlayerAttempt: Identifiable, Codable, Hashable {
        let id: UUID
        
        let player: Player
        var score: Int = 0
        
        init(id: UUID = UUID(), player: Player, score: Int) {
            self.id = id
            self.player = player
            self.score = score
        }
    }
}

extension MolkkyRound {
    static let sampleData: MolkkyRound = MolkkyRound(players: Person.sampleData)
}
