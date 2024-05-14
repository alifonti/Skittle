//
//  CurrentSettingsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/13/24.
//

import SwiftUI

struct CurrentGameRulesView: View {
    let round: MolkkyRound
    
    var body: some View {
        Group {
            VStack {
                LabeledContent("Target Score") {
                    Text(String(round.targetScore))
                }
                LabeledContent("Can be eliminated") {
                    Text(String(round.canBeEliminated))
                }
                LabeledContent("Misses for elimination") {
                    Text(String(round.missesForElimination))
                }
                LabeledContent("Can be reset") {
                    Text(String(round.canBeReset))
                }
                LabeledContent("Score after reset") {
                    Text(String(round.resetScore))
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Game Rules")
    }
}

struct CurrentGameRulesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentGameRulesView(round: MolkkyRound.sampleData)
    }
}
