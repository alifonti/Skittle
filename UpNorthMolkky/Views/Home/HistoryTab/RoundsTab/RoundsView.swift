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
        VStack {
            HStack {
                Spacer()
                Button(editMode == EditMode.inactive ? "Edit" : "Done") {
                    editMode = editMode == EditMode.inactive ? EditMode.active : EditMode.inactive
                }
            }
            .padding()
            List {
                ForEach($rounds, id: \.id) { $round in
                    NavigationLink(destination: ScoreboardView(round: $round)) {
                        CardView(round: round)
                    }
                }
                .onDelete { rounds.remove(atOffsets: $0) }
            }
            .listStyle(.automatic)
            .environment(\.editMode, $editMode)
        }
    }
}

struct RoundsView_Previews: PreviewProvider {
    static var previews: some View {
        RoundsView(rounds: .constant([MolkkyRound.sampleData]))
    }
}
