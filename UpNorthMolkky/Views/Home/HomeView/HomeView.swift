//
//  HomeView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 10/4/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: MolkkyStore
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var path = NavigationPath()
    @State private var selectedTab = "play"
    
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeHeaderView(selectedTab: $selectedTab)
            TabView(selection: $selectedTab) {
                Group {
                    PlayTabView(userData: $store.userData, navPath: $path)
                        .tabItem {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                        .tag("play")
                    HistoryTabView(userData: $store.userData, navPath: $path)
                        .tabItem {
                            Image(systemName: "book.pages.fill")
                            Text("History")
                        }
                        .tag("history")
                    Text("More Screen")
                        .tabItem {
                            Image(systemName: "ellipsis")
                            Text("More")
                        }
                        .tag("more")
                }
            }
            .tint(HomeHeaderView.getHeaderColor(tab: selectedTab))
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
