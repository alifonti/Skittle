//
//  EditScoreSheet.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/16/23.
//

import SwiftUI

struct EditScoreSheet: View {
    @Binding var attempt: MolkkyRound.PlayerAttempt
    @Binding var isPresentingEditScoreView: Bool
    
    @State var editAttempt: MolkkyRound.PlayerAttempt
    
    init(attempt: Binding<MolkkyRound.PlayerAttempt>, isPresentingEditScoreView: Binding<Bool>) {
        self._attempt = attempt
        self._editAttempt = State(initialValue: attempt.wrappedValue)
        self._isPresentingEditScoreView = isPresentingEditScoreView
    }
    
    var body: some View {
        NavigationStack {
            EditView(attempt: $attempt, editAttempt: $editAttempt)
                .navigationTitle("Edit Throw")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditScoreView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            attempt = editAttempt
                            isPresentingEditScoreView = false
                        }
                    }
                }
        }
    }
}

struct EditView: View {
    @Binding var attempt: MolkkyRound.PlayerAttempt
    @Binding var editAttempt: MolkkyRound.PlayerAttempt
    
    func editScore(value: Int) {
        editAttempt = MolkkyRound.PlayerAttempt(player: attempt.player, score: value)
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Divider()
                VStack {
                    Text(editAttempt.player.playerName)
                    ScoreboardView.getNumberAsText(value: editAttempt.score)
                }
                Divider()
            }
            .fixedSize(horizontal: false, vertical: true)
            Spacer()
//            ScoreKeyboardView(onSubmitScore: editScore)
//                .padding()
        }
    }
}


struct EditScoreSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditScoreSheet(attempt: .constant(MolkkyRound.PlayerAttempt(player: Player(playerName: "Anthony", orderKey: 0), score: 1)), isPresentingEditScoreView: .constant(true))
    }
}
