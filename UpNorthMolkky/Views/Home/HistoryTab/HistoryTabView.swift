//
//  HistoryTabView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/18/24.
//

import SwiftUI

struct HistoryTabView: View {
    @Binding var rounds: [MolkkyRound]
    @Binding var players: [Player]
    @Binding var navPath: NavigationPath
    
    @State var selectedTab: HistoryTabView.Tab = HistoryTabView.Tab.rounds
    
    var people: [Player] = []
    
    func getColor(tab: HistoryTabView.Tab) -> Color {
        return tab == selectedTab ? Color(hue: 0.8, saturation: 0.6, brightness: 0.8) : Color(UIColor.label)
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
            if (selectedTab == HistoryTabView.Tab.rounds) {
                RoundsView(rounds: $rounds, navPath: $navPath)
            } else if (selectedTab == HistoryTabView.Tab.people) {
                PlayersView(players: players)
            } else if (selectedTab == HistoryTabView.Tab.stats) {
                Text("Stats")
            }
            Spacer()
        }
    }
}

struct HistoryTabView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTabView(rounds: .constant([MolkkyRound.sampleData]), players: .constant(Player.sampleData), navPath: .constant(NavigationPath()))
            .environmentObject(MolkkyStore())
    }
}

extension HistoryTabView {
    enum Tab {
        case rounds, people, stats
    }
}
