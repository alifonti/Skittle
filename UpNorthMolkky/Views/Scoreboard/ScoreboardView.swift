//
//  ContentView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/12/23.
//

import SwiftUI

struct ScoreboardView: View {
    @Binding var round: MolkkyRound
    
    @State private var isPresentingOptionsView = false
    @State private var isPresentingResultsView = false
    
    init(round: Binding<MolkkyRound>) {
        _round = round
        _isPresentingResultsView = State(initialValue: round.wrappedValue.hasGameEnded)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                PlayerScoresListView(round: $round)
                ScoreControlsView(round: $round)
            }
            .navigationTitle("Scoreboard")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresentingOptionsView = true
                    }) {
                        Label("Label", systemImage: "gear")
                            .foregroundColor(Color(UIColor.label))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    SortToggleButton(round: $round)
                }
            }
            .onChange(of: $round.wrappedValue.hasGameEnded) {
                isPresentingResultsView = round.hasGameEnded
            }
            .sheet(isPresented: $isPresentingOptionsView) {
                ScoreboardOptionsSheet(round: $round, isPresentingOptionsView: $isPresentingOptionsView)
                    .presentationDetents([.medium])
            }
            .fullScreenCover(isPresented: $isPresentingResultsView, onDismiss: {}) {
                ScoreboardResultsView(round: $round, isPresenting: $isPresentingResultsView)
            }
        }
    }
}

extension ScoreboardView {
    @ViewBuilder
    static func getNumberAsText(value: Int) -> some View {
        if (value == 0) {
            Text(String("0"))
        } else {
            Text(String(value))
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView(round: .constant(MolkkyRound.sampleData))
    }
}
