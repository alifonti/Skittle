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
    
    var funListColor: Color = Color(named: "s.accent3.main").opacity(0.25)
    var listColor: Color = Color(named: "s.fill.quaternary")
    var listTextColor: Color {
        return Color(UIColor.label)
    }
    
    func resetToDefault() {
        round.targetScore = 50
        round.canBeEliminated = true
        round.missesForElimination = 3
        round.canBeReset = true
        round.resetScore = 25
        round.resetInsteadOfEliminate = false
        round.canExceedTarget = false
        funRules = false
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: resetToDefault) {
                    HStack {
                        Spacer()
                        HStack {
                            Text("Reset to default")
                                .fontWeight(.medium)
                                .foregroundStyle(Color(UIColor.secondaryLabel))
                        }
                        .padding(.vertical, 10)
                        Spacer()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.secondaryLabel).opacity(0.75))
                    )
                }
                Spacer()
                Toggle("", isOn: $funRules)
                    .toggleStyle(PartyToggleStyle())
                    .padding([.horizontal], 22)
                    .padding([.vertical], 5)
            }
            .padding([.leading, .trailing], 22)
            .padding([.top], 5)
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
                            NumberInput(value: $round.missesForElimination, increment: 1, minimumValue: 1, maximumValue: 3)
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
//                    if (!round.canBeReset && funRules) {
//                        Toggle("Players can win by exceeding target score", isOn: $round.canExceedTarget)
//                            .toggleStyle(CheckmarkToggleStyle())
//                            .listRowBackground(funListColor)
//                    }
                }
                // TODO: Implement in a future version
//                if (funRules) {
//                    Section(header: Text("Additional rules")) {
//                        Toggle("Keep playing after first finisher", isOn: $round.continueUntilAllFinished)
//                            .toggleStyle(CheckmarkToggleStyle())
//                            .listRowBackground(funListColor)
//                        Toggle("All players get the same number of throws", isOn: $round.allPlayersGetEqualThrows)
//                            .toggleStyle(CheckmarkToggleStyle())
//                            .listRowBackground(funListColor)
//                    }
//                }
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
