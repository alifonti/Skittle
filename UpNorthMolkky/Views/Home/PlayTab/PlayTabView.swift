//
//  PlayTab.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/18/24.
//

import SwiftUI

struct PlayTabView: View {
    @Binding var userData: SkittleData
    @Binding var isNavigationActive: Bool
    @Binding var newRound: MolkkyRound
    
    @State private var isPresentingNewRoundView: Bool = false
    @State private var shouldNavigate: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            PlayTabCard(variant: .secondary, title: "Rules of the game", imageName: "book", buttonLabel: "View rules")
            PlayTabCard(variant: .primary, title: "Ready to play?", imageName: "play.circle", buttonLabel: "Start a new round", buttonColor: Color(named: "s.accent1.main"),
                onClick: {
                    isPresentingNewRoundView = true
                    newRound = MolkkyRound(players: [])
                }
            )
            if (shouldNavigate) {
                ProgressView()
            }
            Spacer()
        }
        .sheet(isPresented: $isPresentingNewRoundView, onDismiss: {
            if (shouldNavigate) {
                isNavigationActive = true
                shouldNavigate = false
            }}) {
            NewRoundSheet(userData: $userData, isPresentingNewRoundView: $isPresentingNewRoundView, shouldNavigate: $shouldNavigate, newRound: $newRound)
        }
        .padding()
    }
}

struct PlayTabView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTabView(userData: .constant(SkittleData.sampleData), isNavigationActive: .constant(false), newRound: .constant(MolkkyRound.sampleData))
    }
}
