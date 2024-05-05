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
        VStack(spacing: 0) {
            HStack {
                Button("Dismiss") {
                    isPresentingNewRoundView = false
                }
                Spacer()
                Button("Start") {
                    userData.addRound(newRound)
                    isPresentingNewRoundView = false
                    shouldNavigate = true
                }
                .disabled(newRound.contenders.count <= 1)
            }
            .padding()
            .background(Color(hue: 0.1, saturation: 0.75, brightness: 0.9, opacity: 0.25))
            DetailEditView(round: $newRound)
        }
    }
}
