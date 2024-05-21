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
    
    @State private var selectedTab = "choose"
    
    func getHeaderText() -> String {
        if (selectedTab == "choose") {
            return "Choose players"
        } else if (selectedTab == "order") {
            return "Organize players"
        } else if (selectedTab == "settings") {
            return "Set rules"
        } else {
            return ""
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()
                    Text(getHeaderText())
                    Spacer()
                }
                .padding()
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
            }
            DetailEditView(round: $newRound, selectedTab: $selectedTab)
        }
        // TODO: Fix this hack... whenever the list of contenders changes, this recreates the list but updates the orderKeys
        .onChange(of: newRound.contenders) {
            newRound.contenders = newRound.contenders.enumerated().map {
                Contender(id: $1.id, name: $1.name, orderKey: $0)
            }
        }
        .interactiveDismissDisabled()
    }
}
