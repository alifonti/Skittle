//
//  HistoryTabView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/18/24.
//

import SwiftUI

struct HistoryTabView: View {
    @Binding var userData: SkittleData
    
    @State var selectedTab: HistoryTabView.Tab = HistoryTabView.Tab.rounds
    
    var people: [Player] = []
    
    func setSelectedTab(_ tab: HistoryTabView.Tab) {
        withAnimation {
            selectedTab = tab
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HistoryTabSelector(selectedTab: selectedTab, setSelectedTab: setSelectedTab(_:))
                // Spacer()
                // Button(editMode == EditMode.inactive ? "Edit" : "Done") {
                //     editMode = editMode == EditMode.inactive ? EditMode.active : EditMode.inactive
                // }
            }
            TabView(selection: $selectedTab.animation(.smooth)) {
                RoundsView(rounds: $userData.rounds)
                    .tabItem {
                        Text("Rounds")
                    }
                    .tag(HistoryTabView.Tab.rounds)
                PlayersView(userData: $userData)
                    .tabItem {
                        Text("People")
                    }
                    .tag(HistoryTabView.Tab.people)
                StatsTabView(userData: $userData)
                    .tabItem {
                        Text("Stats")
                    }
                    .tag(HistoryTabView.Tab.stats)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

struct HistoryTabView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTabView(userData: .constant(SkittleData.sampleData))
            .environmentObject(MolkkyStore())
    }
}

extension HistoryTabView {
    enum Tab {
        case rounds, people, stats
    }
}
