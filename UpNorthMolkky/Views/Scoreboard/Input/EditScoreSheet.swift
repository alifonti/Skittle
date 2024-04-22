//
//  EditScoreSheet.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/16/23.
//

import SwiftUI

struct EditScoreSheet: View {
    @Binding var attempt: MolkkyRound.ContenderAttempt
    @Binding var isPresentingEditScoreView: Bool
    
    @State var editAttempt: MolkkyRound.ContenderAttempt
    
    init(attempt: Binding<MolkkyRound.ContenderAttempt>, isPresentingEditScoreView: Binding<Bool>) {
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
    @Binding var attempt: MolkkyRound.ContenderAttempt
    @Binding var editAttempt: MolkkyRound.ContenderAttempt
    
    func editScore(value: Int) {
        editAttempt = MolkkyRound.ContenderAttempt(player: attempt.contender, score: value)
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Divider()
                VStack {
                    Text(editAttempt.contender.name)
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
        EditScoreSheet(attempt: .constant(MolkkyRound.ContenderAttempt(player: Contender(name: "Anthony", orderKey: 0), score: 1)), isPresentingEditScoreView: .constant(true))
    }
}
