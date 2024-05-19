//
//  GameRulesView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/6/24.
//

import SwiftUI

struct GameRulesView: View {
    @Binding var round: MolkkyRound
    
    @State private var funRules: Bool = false
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var funListColor: Color = Color(hue: 0.6, saturation: 0.25, brightness: 0.95)
    var listColor: Color {
        return Color(UIColor.systemFill)
    }
    var listTextColor: Color {
        return Color(UIColor.label)
    }
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Spacer()
                    HStack {
                        Text("Reset to default")
                    }
                    .padding(.vertical, 10)
                    Spacer()
                }
                .background(Color(UIColor.systemFill))
                .cornerRadius(10)
                Spacer()
                Toggle("Fun rules", isOn: $funRules)
                    .toggleStyle(PartyToggleStyle())
                    .padding([.horizontal], 22)
                    .padding([.vertical], 5)
            }
            .padding([.leading, .trailing], 22)
            .padding([.top], 5)
            Divider()
            //
            Form {
                Section(header: Text("Target Score")) {
                    LabeledContent {
                        NumberInput(value: $round.targetScore, increment: 5, minimumValue: 20, maximumValue: 100)
                            .fixedSize()
                            .foregroundColor(listTextColor)
                    } label: {
                        HStack {
                            Text("Target Score")
                                .foregroundColor(listTextColor)
                        }
                    }
                    .listRowBackground(listColor)
                }
                Section(header: Text("Player elimination")) {
                    Toggle("Eliminate players", isOn: $round.canBeEliminated)
                        .toggleStyle(CheckmarkToggleStyle())
                        .listRowBackground(listColor)
                    if (round.canBeEliminated) {
                        LabeledContent {
                            NumberInput(value: $round.missesForElimination, increment: 1, minimumValue: 1, maximumValue: 5)
                                .fixedSize()
                                .foregroundColor(listTextColor)
                        } label: {
                            HStack {
                                Text("Misses")
                            }
                        }
                        .listRowBackground(listColor)
                    }
                    if (round.canBeEliminated && funRules) {
                        Toggle("Set score to 0 instead of eliminating player", isOn: $round.resetInsteadOfEliminate)
                            .toggleStyle(CheckmarkToggleStyle())
                            .listRowBackground(funListColor)
                    }
                }
                Section(header: Text("Score reset")) {
                    Toggle("Reset scores on bust", isOn: $round.canBeReset)
                        .toggleStyle(CheckmarkToggleStyle())
                        .listRowBackground(listColor)
                    if (round.canBeReset) {
                        LabeledContent {
                            NumberInput(value: $round.resetScore, increment: 5, minimumValue: 0, maximumValue: round.targetScore - 5)
                                .fixedSize()
                                .foregroundColor(listTextColor)
                        } label: {
                            HStack {
                                Text("Score after reset")
                            }
                        }
                        .listRowBackground(listColor)
                    }
                    if (!round.canBeReset && funRules) {
                        Toggle("Players can win by exceeding target score", isOn: $round.canExceedTarget)
                            .toggleStyle(CheckmarkToggleStyle())
                            .listRowBackground(funListColor)
                    }
                }
                if (funRules) {
                    Section(header: Text("Additional rules")) {
                        Toggle("Keep playing after first finisher", isOn: $round.continueUntilAllFinished)
                            .toggleStyle(CheckmarkToggleStyle())
                            .listRowBackground(funListColor)
                        Toggle("All players get the same number of throws", isOn: $round.allPlayersGetEqualThrows)
                            .toggleStyle(CheckmarkToggleStyle())
                            .listRowBackground(funListColor)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .onChange(of: round.targetScore) {
                if (round.targetScore <= round.resetScore) {
                    round.resetScore = round.targetScore - 5
                }
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationTitle("Set Game Rules")
    }
}

struct GameRulesView_Previews: PreviewProvider {
    static var previews: some View {
        GameRulesView(round: .constant(MolkkyRound.sampleData))
    }
}
