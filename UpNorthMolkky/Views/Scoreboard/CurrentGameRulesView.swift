//
//  CurrentSettingsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/13/24.
//

import SwiftUI

struct CurrentGameRulesView: View {
    let round: MolkkyRound
    
    func getString(_ bool: Bool) -> String {
        return bool ? "Yes" : "No"
    }
    
    var body: some View {
        Group {
            VStack(spacing: 20) {
                VStack {
                    LabeledContent("Target score") {
                        Text(String(round.targetScore))
                    }
                }
                Divider()
                VStack {
                    LabeledContent("Players can be eliminated") {
                        Text(getString(round.canBeEliminated))
                    }
                    if (round.canBeEliminated) {
                        LabeledContent("Misses for elimination") {
                            Text(String(round.missesForElimination))
                        }
                    }
                    if (round.resetInsteadOfEliminate) {
                        LabeledContent("Reset instead of elimination") {
                            Text(getString(round.resetInsteadOfEliminate))
                        }
                    }
                }
                Divider()
                VStack {
                    LabeledContent("Player can be reset") {
                        Text(getString(round.canBeReset))
                    }
                    if (round.canBeReset) {
                        LabeledContent("Score after reset") {
                            Text(String(round.resetScore))
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Customized Rules")
    }
}

struct CurrentGameRulesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentGameRulesView(round: MolkkyRound.sampleData)
    }
}
