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
    
    func shuffle() {
        round.contenders.shuffle()
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
                if (round.contenders.count > 0) {
                    if (isShuffle) {
                        HStack {
                            Button(action: shuffle) {
                                Text("Tap to re-shuffle")
                            }
                        }
                        .font(.callout)
                        .foregroundStyle(Color(named: "s.accent1.main"))
                    } else {
                        HStack {
                            Image(systemName: "hand.tap")
                            Text("Press and hold to move")
                        }
                        .font(.callout)
                        .foregroundStyle(Color(UIColor.secondaryLabel))
                    }
                } else {
                    VStack {
                        Spacer()
                        Image(systemName: "person.fill.badge.plus")
                        Text("Add players before setting the order!")
                        Spacer()
                    }
                }
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

