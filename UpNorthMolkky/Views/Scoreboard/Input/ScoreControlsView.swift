//
//  ContentView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/12/23.
//

import SwiftUI

struct ScoreControlsView: View {
    @Binding var round: MolkkyRound
    
    func addScore(value: Int) {
        round.recordAttempt(attempt: MolkkyRound.ContenderAttempt(player: round.currentContender, score: value))
        round.clearUndoStack()
    }
    
    var body: some View {
        VStack() {
            ScoreHistoryView(round: $round)
                .padding([.top], 8)
                .padding([.bottom], -10)
            ScoreKeyboardView(round: $round, onSubmitScore: addScore)
                .padding()
        }
        .background(Color(named: "s.background.secondary"))
    }
}

struct ScoreControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreControlsView(round: .constant(MolkkyRound.sampleData))
    }
}
