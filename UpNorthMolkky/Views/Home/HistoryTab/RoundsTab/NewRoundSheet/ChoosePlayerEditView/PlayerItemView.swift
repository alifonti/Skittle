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
    
    let selectedColor: Color = Color(hue: 0.6, saturation: 0.25, brightness: 0.95)
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
        .cornerRadius(5)
    }
}
