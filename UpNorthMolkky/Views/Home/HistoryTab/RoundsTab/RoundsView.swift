//
//  RoundsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/16/23.
//

import SwiftUI

struct RoundsView: View {
    @Binding var rounds: [MolkkyRound]
    
    @State var editMode = EditMode.inactive
    
    var body: some View {
        List {
            ForEach($rounds, id: \.id) { $round in
                NavigationLink(destination: ScoreboardView(round: $round)) {
                    CardView(round: round)
                }
            }
            .onDelete { rounds.remove(atOffsets: $0) }
            .deleteDisabled(!self.editMode.isEditing)
            .listRowBackground(Color(named: "s.fill.tertiary"))
        }
        .animation(nil, value: editMode)
        .scrollContentBackground(.hidden)
        .background(Color(named: "s.background.primary"))
//        .overlay {
//            VStack {
//                Rectangle()
//                    .fill(Color(named: "s.background.primary"))
//                    .shadow(radius: 10, x: 0, y: 5)
//                    .frame(height: 20)
//                Spacer()
//                Rectangle()
//                    .fill(Color(named: "s.background.primary"))
//                    .shadow(radius: 10, x: 0, y: -5)
//                    .frame(height: 20)
//            }
//            .ignoresSafeArea()
//        }
        .environment(\.editMode, $editMode)
    }
}

struct RoundsView_Previews: PreviewProvider {
    static var previews: some View {
        RoundsView(rounds: .constant([MolkkyRound.sampleData]))
    }
}
