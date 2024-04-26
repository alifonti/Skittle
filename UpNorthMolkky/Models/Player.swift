//
//  Person.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 10/7/23.
//
//  Player.swift
//  UpNorthMolkky
//
//  Renamed by Anthony LiFonti on 4/21/24.
//

import Foundation

struct Player: Identifiable, Codable, Hashable {
    let id: UUID
    let createTime: Date
    var playerName: String
    
    init(id: UUID = UUID(), playerName: String) {
        self.id = id
        self.playerName = playerName
        self.createTime = Date.now
    }
    
    mutating func updateName(name: String) {
        playerName = name
    }
}

extension Player {
    static let sampleData: [Player] =
    [
        Player(playerName: "Anthony"),
        Player(playerName: "Emma")
    ]
}
