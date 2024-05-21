//
//  PlayerItemView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/4/24.
//

import SwiftUI

struct PlayerItemView: View {
    
    var player: Player
    var selected: Bool
    
    let selectedColor: Color = Color(named: "s.accent2.main")
    let unselectedColor: Color = Color(UIColor.secondarySystemFill)
    
    var body: some View {
        HStack {
            Text(player.playerName)
                .padding()
            Spacer()
            Image(systemName: "checkmark")
                .padding()
                .opacity(selected ? 1 : 0)
        }
        .background(selected ? selectedColor : unselectedColor)
        .foregroundStyle(selected ? Color(named: "s.accent.foreground") : Color(UIColor.label))
        .cornerRadius(5)
    }
}
