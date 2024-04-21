//
//  EditScoreSheetHistory.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/16/23.
//

import SwiftUI

struct EditScoreHistorySheet: View {
    @Binding var round: MolkkyRound
    @Binding var isPresentingEditScoreView: Bool
    
    @State var editedHistory: [MolkkyRound.PlayerAttempt]
    
    init(round: Binding<MolkkyRound>, isPresentingEditScoreView: Binding<Bool>) {
        self._round = round
        self._editedHistory = State(initialValue: round.attempts.wrappedValue)
        self._isPresentingEditScoreView = isPresentingEditScoreView
    }
    
    var body: some View {
        NavigationStack {
            EditHistoryView(round: $round, editedHistory: $editedHistory)
                .navigationTitle("Edit Previous Throws")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditScoreView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            round.attempts = editedHistory
                            isPresentingEditScoreView = false
                        }
                    }
                }
        }
    }
}

struct EditHistoryView: View {
    @Binding var round: MolkkyRound
    @Binding var editedHistory: [MolkkyRound.PlayerAttempt]
    
    func editScore(value: Int) {
//        editAttempt = MolkkyRound.PlayerAttempt(player: attempt.player, score: value)
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(round.attempts, id: \.id) { attempt in
                        HStack {
                            Text(attempt.player.playerName)
                            Spacer()
                            Text(String(attempt.score))
                        }
                        .padding()
                    }
                }
            }
            Spacer()
            ScoreKeyboardView(round: $round, onSubmitScore: editScore)
                .padding()
        }
    }
}


//struct EditScoreHistorySheet_Previews: PreviewProvider {
//    static var previews: some View {
//        EditScoreHistorySheet(history: .constant([MolkkyRound.PlayerAttempt(player: Player(playerName: "Anthony", orderKey: 0), score: 1)]), isPresentingEditScoreView: .constant(true))
//    }
//}
