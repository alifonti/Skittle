//
//  GameRulesEditView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/4/24.
//

import SwiftUI

struct GameRulesEditView: View {
    @Binding var round: MolkkyRound
    
    var body: some View {
        GameRulesView(round: $round)
            .navigationTitle("Set Game Rules")
    }
}

struct GameRulesEditView_Previews: PreviewProvider {
    static var previews: some View {
        GameRulesEditView(round: .constant(MolkkyRound.sampleData))
    }
}
