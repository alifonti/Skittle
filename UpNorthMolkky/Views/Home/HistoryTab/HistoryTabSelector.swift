//
//  HistoryTabSelector.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/1/24.
//

import SwiftUI

struct HistoryTabSelector: View {
    let selectedTab: HistoryTabView.Tab
    let setSelectedTab: (HistoryTabView.Tab) -> Void
    
    func getColor(tab: HistoryTabView.Tab) -> Color {
        return tab == selectedTab ? Color(named: "s.accent2.main").opacity(0.8) : Color(UIColor.clear)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            HistoryTabSelectorButton(tab: HistoryTabView.Tab.rounds, selectedTab: selectedTab, setSelectedTab: setSelectedTab,
                 image: "clipboard.fill", text: "Rounds", color: getColor(tab: HistoryTabView.Tab.rounds))
            HistoryTabSelectorButton(tab: HistoryTabView.Tab.people, selectedTab: selectedTab, setSelectedTab: setSelectedTab,
                 image: "person.2.fill", text: "People", color: getColor(tab: HistoryTabView.Tab.people))
            HistoryTabSelectorButton(tab: HistoryTabView.Tab.stats, selectedTab: selectedTab, setSelectedTab: setSelectedTab,
                 image: "chart.bar.fill", text: "Overall", color: getColor(tab: HistoryTabView.Tab.stats))
        }
        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct HistoryTabSelectorButton: View {
    let tab: HistoryTabView.Tab
    let selectedTab: HistoryTabView.Tab
    let setSelectedTab: (HistoryTabView.Tab) -> Void
    let image: String
    let text: String
    let color: Color
    
    var body: some View {
        Button(action: {
            setSelectedTab(tab)
        }, label: {
            HStack(alignment: .firstTextBaseline) {
                Image(systemName: image)
                    .foregroundStyle(Color(UIColor.label))
                if (tab == selectedTab) {
                    Text(text)
                        .foregroundStyle(Color(UIColor.label))
                        .font(.headline)
                        .frame(width: tab == selectedTab ? nil : 0, alignment: .leading)
                        .clipped()
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .offset(x: 0, y: -1)
        })
        .background(color)
        .clipShape(Capsule(style: .circular))
    }
}

struct HistoryTabSelector_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTabSelector(selectedTab: HistoryTabView.Tab.rounds, setSelectedTab: {_ in})
    }
}
