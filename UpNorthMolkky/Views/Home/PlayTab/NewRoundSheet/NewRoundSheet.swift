//
//  NewRoundSheet.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/3/24.
//
import SwiftUI

struct NewRoundSheet: View {
    @EnvironmentObject var navigationState: NavigationState
    
    @Binding var userData: SkittleData
    @Binding var isPresentingNewRoundView: Bool
    @Binding var shouldNavigate: Bool
    @Binding var newRound: MolkkyRound
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Dismiss") {
                    isPresentingNewRoundView = false
                }
                Spacer()
                Button("Start") {
                    userData.addRound(newRound)
                    navigationState.activeRoundId = newRound.id
                    isPresentingNewRoundView = false
                    shouldNavigate = true
                }
                .disabled(newRound.contenders.count <= 1)
            }
            .padding()
            DetailEditView(round: $newRound)
        }
    }
}
