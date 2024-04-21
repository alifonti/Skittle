//
//  PlayerEditView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/3/24.
//

import SwiftUI

struct ChoosePlayerEditView: View {
    @Binding var round: MolkkyRound
    
    var body: some View {
        PlayerListView(round: $round)
            .navigationTitle("Choose Players")
    }
}


struct ChoosePlayerEditView_Previews: PreviewProvider {
    static var previews: some View {
        ChoosePlayerEditView(round: .constant(MolkkyRound.sampleData))
    }
}
