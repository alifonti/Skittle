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
    
    func startNewRound() {
        isPresentingNewRoundView = true
        newRound = MolkkyRound(players: [])
    }
    
    var body: some View {
        ZStack {
            Group {
                VStack(spacing: 15) {
                    GenericPlayTabCard(title: "Rules of the game", imageName: "book",
                                       buttonLabel: "View rules", buttonColor: Color(UIColor.quaternarySystemFill),
                                       buttonLabelColor: Color(UIColor.label))
                    MainPlayCard(newGameOnClick: startNewRound, rounds: $userData.rounds)
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
            Group {
                if (shouldNavigate) {
                    VStack {
                        Text("Starting a new round")
                            .font(.title3)
                        ProgressView()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(.thinMaterial))
                } else {
                    EmptyView()
                }
            }
        }
    }
}

struct PlayTabView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTabView(userData: .constant(SkittleData.sampleData), isNavigationActive: .constant(false), newRound: .constant(MolkkyRound.sampleData))
    }
}
