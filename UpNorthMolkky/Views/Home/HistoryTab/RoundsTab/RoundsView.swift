//
//  RoundsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/16/23.
//

import SwiftUI

struct RoundsView: View {
    @Binding var rounds: [MolkkyRound]
    @Binding var navPath: NavigationPath
    
    var body: some View {
        VStack {
            List($rounds, id: \.id, editActions: .delete) { $round in
                NavigationLink(destination: ScoreboardView(round: $round)) {
                    CardView(round: round)
                }
            }
            .listStyle(.automatic)
        }
    }
}

struct RoundsView_Previews: PreviewProvider {
    static var previews: some View {
        RoundsView(rounds: .constant([MolkkyRound.sampleData]), navPath: .constant(NavigationPath()))
    }
}
