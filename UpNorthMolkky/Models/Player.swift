//
//  Player.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/12/23.
//

import Foundation

struct Player: Identifiable, Codable, Hashable {
    let id: UUID
    let playerName: String
    let orderKey: Int
    
    init(id: UUID = UUID(), playerName: String, orderKey: Int) {
        self.id = id
        self.playerName = playerName
        self.orderKey = orderKey
    }
}

extension Player {
    static let sampleData: [Player] =
    [
        Player(playerName: "Anthony", orderKey: 0),
        Player(playerName: "Emma", orderKey: 1),
        Player(playerName: "Other", orderKey: 2),
        Player(playerName: "Somebody", orderKey: 3),
        Player(playerName: "Nobody", orderKey: 4),
    ]
}
