//
//  PlayersView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/6/24.
//

import SwiftUI

struct PlayersView: View {
    
    var players: [Player]
    
    var body: some View {
        List {
            ForEach(players, id: \.id) { player in
                NavigationLink(destination: PlayerDetailsView(player: player)) {
                    HStack {
                        Text(player.playerName)
                        Spacer()
                        Text("x rounds played")
                    }
                }
            }
        }
    }
}

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(players: [])
    }
}
