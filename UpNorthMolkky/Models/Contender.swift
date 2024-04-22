//
//  Player.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/12/23.
//
//  Contender.swift
//  UpNorthMolkky
//
//  Renamed by Anthony LiFonti on 4/21/24.

import Foundation

struct Contender: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let orderKey: Int
    
    init(id: UUID = UUID(), name: String, orderKey: Int) {
        self.id = id
        self.name = name
        self.orderKey = orderKey
    }
}

extension Contender {
    static let sampleData: [Contender] =
    [
        Contender(name: "Anthony", orderKey: 0),
        Contender(name: "Emma", orderKey: 1),
        Contender(name: "Other", orderKey: 2),
        Contender(name: "Somebody", orderKey: 3),
        Contender(name: "Nobody", orderKey: 4),
    ]
}
