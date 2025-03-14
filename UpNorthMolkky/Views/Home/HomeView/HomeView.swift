//
//  HomeView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 10/4/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: MolkkyStore
    @EnvironmentObject var navigationState: NavigationState
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var selectedTab = "play"
    
    @State private var newRound: MolkkyRound = MolkkyRound(players: [])
    
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HomeHeaderView(selectedTab: $selectedTab)
                TabView(selection: $selectedTab) {
                    Group {
                        PlayTabView(userData: $store.userData, newRound: $newRound)
                            .tabItem {
                                Image(systemName: "play.fill")
                                Text("Play")
                            }
                            .tag("play")
                        HistoryTabView(userData: $store.userData)
                            .tabItem {
                                Image(systemName: "book.pages.fill")
                                Text("History")
                            }
                            .tag("history")
                        MoreTabView()
                            .tabItem {
                                Image(systemName: "ellipsis")
                                Text("More")
                            }
                            .tag("more")
                    }
                    // .toolbarBackground(Material.regular, for: .tabBar)
                    // .toolbarBackground(.visible, for: .tabBar)
                }
                .tint(HomeHeaderView.getHeaderColor(tab: selectedTab))
            }
            .navigationDestination(isPresented: $navigationState.isNavigationActive) {
                ScoreboardView(round: $store.userData.rounds.first(where: {
                    $0.id == navigationState.activeRoundId
                }) ?? .constant(MolkkyRound.sampleData))
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive { saveAction() }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(saveAction: {})
            .environmentObject(MolkkyStore())
    }
}
