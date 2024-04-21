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
    
    @State private var headerColor: Color = Color(hue: 0.6, saturation: 0.6, brightness: 0.8)
    @State private var headerText: String = "play"
    
    let saveAction: () -> Void
    
    func getHeaderColor(tab: String) -> Color {
        if (tab == "play") {
            return Color(hue: 0.6, saturation: 0.6, brightness: 0.8)
        } else if (tab == "history") {
            return Color(hue: 0.8, saturation: 0.6, brightness: 0.8)
        } else if (tab == "more") {
            return Color(hue: 0.0, saturation: 0.6, brightness: 0.8)
        } else {
            return Color(hue: 0.6, saturation: 0.6, brightness: 0.8)
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack() {
                HStack(alignment: .center, spacing: 1) {
                    Text("Skittle")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(headerText)
                        .id(headerText)
                        .foregroundStyle(headerColor)
                        .font(.largeTitle)
                        .fontWeight(.regular)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .top).combined(with: .opacity)
                        ))
                }
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(gradient: Gradient(colors: [headerColor.opacity(0.25), headerColor.opacity(0)]), startPoint: .top, endPoint: .bottom)
            )
            TabView(selection: $selectedTab) {
                Group {
                    PlayTabView(userData: $store.userData, navPath: $path)
                        .tabItem {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                        .tag("play")
                    HistoryTabView(rounds: $store.userData.rounds, players: $store.userData.players, navPath: $path)
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
            .tint(headerColor)
            .onChange(of: selectedTab) {
                withAnimation(Animation.linear(duration: 0.25)) {
                    headerColor = getHeaderColor(tab: selectedTab)
                    headerText = selectedTab
                }
            }
//            .navigationDestination(for: MolkkyRound.self) { round in
//                ScoreboardView(round: round)
//            }
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
