//
//  NavigationState.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/7/24.
//

import Foundation

class NavigationState: ObservableObject {
    @Published var isNavigationActive: Bool = false
    @Published var activeRoundId: UUID?
}
