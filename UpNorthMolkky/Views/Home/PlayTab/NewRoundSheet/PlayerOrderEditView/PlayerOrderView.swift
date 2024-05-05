//
//  PlayerOrderView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/4/24.
//

import SwiftUI

struct PlayerOrderView: View {
    @Binding var round: MolkkyRound
    
    @State private var isShuffle: Bool = true
    @State private var isTeams: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Picker("Grouping", selection: $isTeams) {
                    Text("Singles").tag(false)
                    Text("Teams").tag(true)
                }.pickerStyle(.segmented)
                Picker("Turn Order", selection: $isShuffle) {
                    Text("Random order").tag(true)
                    Text("Set order").tag(false)
                }.pickerStyle(.segmented)
            }
            Divider()
                .padding(.vertical, 10)
            ScrollView(showsIndicators: false, content: {
                VStack(spacing: 10, content: {
                    ForEach(round.contenders, id: \.self) { contender in
                        PlayerOrderItemView(title: contender.name, index: round.contenders.firstIndex(of: contender) ?? 0,
                            hideOrderedDetails: isShuffle)
                    }
                    Spacer()
                })
            })
        }
        .padding()
    }
}


struct PlayerOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerOrderView(round: .constant(MolkkyRound.sampleData))
    }
}

