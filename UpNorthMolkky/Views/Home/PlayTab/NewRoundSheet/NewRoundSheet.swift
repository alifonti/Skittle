//
//  NewRoundSheet.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/3/24.
//
import SwiftUI

struct NewRoundSheet: View {
    @Binding var userData: SkittleData
    @Binding var isPresentingNewRoundView: Bool
    @Binding var shouldNavigate: Bool
    @Binding var newRound: MolkkyRound
    
    var body: some View {
        VStack {
            HStack {
                Button("Dismiss") {
                    isPresentingNewRoundView = false
                }
                Spacer()
                Text("Setup")
                Spacer()
                Button("Start") {
                    userData.addRound(newRound)
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
