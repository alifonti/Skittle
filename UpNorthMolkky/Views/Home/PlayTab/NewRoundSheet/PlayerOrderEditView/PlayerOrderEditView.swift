//
//  PlayerOrderEditView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/6/24.
//

import SwiftUI

struct PlayerOrderEditView: View {
    @Binding var round: MolkkyRound
    
    var body: some View {
        PlayerOrderView(round: $round)
            .navigationTitle("Set Order of Play")
    }
}


struct PlayerOrderEditView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerOrderEditView(round: .constant(MolkkyRound.sampleData))
    }
}
