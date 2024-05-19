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
    
    func move(from source: IndexSet, to destination: Int) {
        round.contenders.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    //                Picker("Grouping", selection: $isTeams) {
                    //                    Text("Singles").tag(false)
                    //                    Text("Teams").tag(true)
                    //                }.pickerStyle(.segmented)
                    Picker("Turn Order", selection: $isShuffle) {
                        Text("Random order").tag(true)
                        Text("Set order").tag(false)
                    }.pickerStyle(.segmented)
                }
                HStack {
                    Image(systemName: "hand.tap")
                    Text("Press and hold to move")
                }
                .font(.callout)
                .foregroundStyle(Color(UIColor.secondaryLabel))
                .opacity(isShuffle ? 0 : 1)
            
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
            List {
                ForEach(round.contenders, id: \.self) { contender in
                    PlayerOrderItemView(title: contender.name, index: round.contenders.firstIndex(of: contender) ?? 0, hideOrderedDetails: isShuffle)
                        .listRowBackground(Color(named: "s.fill.quaternary"))
                        .moveDisabled(isShuffle)
                }
                .onMove(perform: move)
            }
            // TODO: Fix this hack... whenever the list of contenders changes, this recreates the list but updates the orderKeys
            .onChange(of: round.contenders) {
                round.contenders = round.contenders.enumerated().map {
                    Contender(id: $1.id, name: $1.name, orderKey: $0)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(named: "s.background.primary"))
            Spacer()
        }
    }
}


struct PlayerOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerOrderView(round: .constant(MolkkyRound.sampleData))
    }
}

