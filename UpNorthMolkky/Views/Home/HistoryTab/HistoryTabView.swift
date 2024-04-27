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
    
    func getColor(tab: HistoryTabView.Tab) -> Color {
        return tab == selectedTab ? Color(named: "s.accent2.main") : Color(UIColor.label)
    }
    
    func setSelectedTab(_ tab: HistoryTabView.Tab) {
        selectedTab = tab
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment:.bottom) {
                Spacer()
                Button(action: {
                    setSelectedTab(HistoryTabView.Tab.rounds)
                }, label: {
                    Image(systemName: "clipboard.fill")
                        .foregroundStyle(getColor(tab: HistoryTabView.Tab.rounds))
                })
                Spacer()
                Button(action: {
                    setSelectedTab(HistoryTabView.Tab.people)
                }, label: {
                    Image(systemName: "person.2.fill")
                        .foregroundStyle(getColor(tab: HistoryTabView.Tab.people))
                })
                Spacer()
                Button(action: {
                    setSelectedTab(HistoryTabView.Tab.stats)
                }, label: {
                    Image(systemName: "chart.bar.fill")
                        .foregroundStyle(getColor(tab: HistoryTabView.Tab.stats))
                })
                Spacer()
            }
            .padding()
            TabView(selection: $selectedTab) {
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
