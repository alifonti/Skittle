//
//  PlayerDetailsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/6/24.
//

import SwiftUI

struct PlayerDetailsView: View {
    
    var player: Person
    
    var body: some View {
        Text(player.playerName)
    }
}

struct PlayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsView(player: Person.sampleData[0])
    }
}
