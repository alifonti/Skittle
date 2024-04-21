//
//  NewRoundSheet.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/3/24.
//
import SwiftUI

struct NewRoundSheet: View {
    @State private var newRound: MolkkyRound = MolkkyRound(players: [])
    
    @Binding var userData: SkittleData
    @Binding var isPresentingNewRoundView: Bool
    @Binding var navPath: NavigationPath
    
    var body: some View {
        NavigationStack {
            DetailEditView(round: $newRound)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewRoundView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        NavigationLink(destination: ScoreboardView(round: $newRound)) {
                            Button("Start") {
                                if (newRound.players.count >= 2) {
                                    userData.addRound(newRound)
                                    isPresentingNewRoundView = false
                                }
                            }
                            .disabled(newRound.players.count <= 1)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
//                .navigationDestination(item: $testRound, destination: {_ in
//                    ScoreboardView(round: $newRound)
//                })
//                .navigationDestination(for: Int.self) { _ in
//                    ScoreboardView(round: $newRound)
//                }
        }
    }
}

struct NewRoundSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewRoundSheet(userData: .constant(SkittleData.sampleData), isPresentingNewRoundView: .constant(true), navPath: .constant(NavigationPath()))
    }
}
