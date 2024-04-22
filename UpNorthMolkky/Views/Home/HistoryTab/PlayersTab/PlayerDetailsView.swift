//
//  PlayerDetailsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/6/24.
//

import SwiftUI

struct PlayerDetailsView: View {
    
    var player: Player
    
    var body: some View {
        Text(player.playerName)
    }
}

struct PlayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsView(player: Player.sampleData[0])
    }
}
