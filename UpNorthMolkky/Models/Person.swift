//
//  Person.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 10/7/23.
//

import Foundation

struct Person: Identifiable, Codable, Hashable {
    let id: UUID
    let playerName: String
    
    init(id: UUID = UUID(), playerName: String) {
        self.id = id
        self.playerName = playerName
    }
}

extension Person {
    static let sampleData: [Person] =
    [
        Person(playerName: "Anthony"),
        Person(playerName: "Emma")
    ]
}
