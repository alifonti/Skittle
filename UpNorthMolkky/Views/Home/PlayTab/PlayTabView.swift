//
//  PlayTab.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/18/24.
//

import SwiftUI

struct PlayTabView: View {
    @EnvironmentObject var navigationState: NavigationState
    
    @Binding var userData: SkittleData
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
                ScrollView {
                    VStack(spacing: 15) {
                        RulesPlayTabCard()
                        MainPlayCard(newGameOnClick: startNewRound, rounds: $userData.rounds)
                        Spacer()
                    }
                }
                .sheet(isPresented: $isPresentingNewRoundView, onDismiss: {
                    if (shouldNavigate) {
                        navigationState.isNavigationActive = true
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
        PlayTabView(userData: .constant(SkittleData.sampleData), newRound: .constant(MolkkyRound.sampleData))
    }
}
