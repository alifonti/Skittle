//
//  GameRulesView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/6/24.
//

import SwiftUI

struct GameRulesView: View {
    @Binding var round: MolkkyRound
    
    @State private var customRules: Bool = true
    @State private var funRules: Bool = false
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var funListColor: Color = Color(hue: 0.6, saturation: 0.25, brightness: 0.95)
    var listColor: Color {
        return customRules ? Color(UIColor.systemFill) : Color(UIColor.quaternarySystemFill)
    }
    var listTextColor: Color {
        return customRules ? Color(UIColor.label) : Color(UIColor.label)
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
                Toggle("", isOn: $funRules)
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
                            .disabled(!customRules)
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
                        .disabled(!customRules)
                        .listRowBackground(listColor)
                    if (round.canBeEliminated) {
                        LabeledContent {
                            NumberInput(value: $round.missesForElimination, increment: 1, minimumValue: 1, maximumValue: 5)
                                .fixedSize()
                                .disabled(!customRules)
                                .foregroundColor(listTextColor)
                        } label: {
                            HStack {
                                Text("Misses")
                            }
                        }
                        .listRowBackground(listColor)
                    }
                    if (round.canBeEliminated && customRules && funRules) {
                        Toggle("Reset player score instead of eliminating them", isOn: $round.resetInsteadOfEliminate)
                            .toggleStyle(CheckmarkToggleStyle())
                            .listRowBackground(funListColor)
                    }
                }
                Section(header: Text("Score reset")) {
                    Toggle("Reset scores on bust", isOn: $round.canBeReset)
                        .toggleStyle(CheckmarkToggleStyle())
                        .disabled(!customRules)
                        .listRowBackground(listColor)
                    if (round.canBeReset) {
                        LabeledContent {
                            NumberInput(value: $round.resetScore, increment: 5, minimumValue: 0, maximumValue: round.targetScore - 5)
                                .fixedSize()
                                .disabled(!customRules)
                                .foregroundColor(listTextColor)
                        } label: {
                            HStack {
                                Text("Score after reset")
                            }
                        }
                        .listRowBackground(listColor)
                    }
                    if (!round.canBeReset && customRules && funRules) {
                        Toggle("Players can win by exceeding target score", isOn: $round.canExceedTarget)
                            .toggleStyle(CheckmarkToggleStyle())
                            .listRowBackground(funListColor)
                    }
                }
                if (customRules && funRules) {
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
            .onTapGesture {
                if (!customRules) {
                    customRules = true
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
