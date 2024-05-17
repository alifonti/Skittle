//
//  RoundsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/16/23.
//

import SwiftUI

struct RoundsView: View {
    @Environment(\.editMode) private var editMode
    @EnvironmentObject var navigationState: NavigationState
    @Binding var rounds: [MolkkyRound]
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    Divider()
                }
                EditButton()
            }
            List {
                ForEach($rounds, id: \.id) { $round in
                    Button(action: {
                        navigationState.activeRoundId = round.id
                        navigationState.isNavigationActive = true
                    }) {
                        CardView(round: round)
                            .deleteDisabled(!(editMode?.wrappedValue.isEditing ?? false))
                    }
                }
                .onDelete { rounds.remove(atOffsets: $0) }
                .listRowBackground(Color(named: "s.fill.tertiary"))
            }
            .scrollContentBackground(.hidden)
            .background(Color(named: "s.background.primary"))
        }
        .padding(.horizontal, 15)
    }
}

struct RoundsView_Previews: PreviewProvider {
    static var previews: some View {
        RoundsView(rounds: .constant([MolkkyRound.sampleData]))
    }
}
