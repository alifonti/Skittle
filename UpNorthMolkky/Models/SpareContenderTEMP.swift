//
//  Contender.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/14/24.
//

import Foundation

//
// Contender is a replacement for the current "Player" model.
// This model represents either a single player or team. It is a single row in the scoreboard.
//
struct SpareContender: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let orderKey: Int
    
    let playerIds: [Contender]?
    
    init(id: UUID = UUID(), name: String, orderKey: Int) {
        self.id = id
        self.name = name
        self.orderKey = orderKey
        self.playerIds = nil
    }
    //
}
