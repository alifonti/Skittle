//
//  RoundsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/16/23.
//

import SwiftUI

struct RoundsView: View {
    @Environment(\.editMode) private var editMode
    @EnvironmentObject var navigationState: NavigationState
    @Binding var rounds: [MolkkyRound]
    
    let sevenDaysAgo: Date = Calendar.current.date(byAdding: DateComponents(day: -7), to: .now) ?? .now
    
    var roundsToday: [Binding<MolkkyRound>] {
        $rounds.filter({ $round in
            Calendar.current.compare(round.date, to: .now, toGranularity: .day) == .orderedDescending ||
            Calendar.current.compare(round.date, to: .now, toGranularity: .day) == .orderedSame
        }).sorted(by: {a, b in
            a.wrappedValue.date > b.wrappedValue.date
        })
    }
    var roundsThisWeek: [Binding<MolkkyRound>] {
        $rounds.filter({ $round in
            Calendar.current.compare(round.date, to: .now, toGranularity: .day) == .orderedAscending &&
            Calendar.current.compare(round.date, to: sevenDaysAgo, toGranularity: .day) == .orderedDescending
        }).sorted(by: {a, b in
            a.wrappedValue.date > b.wrappedValue.date
        })
    }
    var roundsOlder: [Binding<MolkkyRound>] {
        $rounds.filter({ $round in
            Calendar.current.compare(round.date, to: sevenDaysAgo, toGranularity: .day) == .orderedSame ||
            Calendar.current.compare(round.date, to: sevenDaysAgo, toGranularity: .day) == .orderedAscending
        }).sorted(by: {a, b in
            a.wrappedValue.date > b.wrappedValue.date
        })
    }
    
    func deleteRound(offsets: IndexSet, list: [Binding<MolkkyRound>]) {
        for offset in offsets {
            if let index = rounds.firstIndex(where: {$0 == list[offset].wrappedValue}) {
                rounds.remove(at: index)
            }
        }
    }
    
    @ViewBuilder
    func RoundSection(roundsSubset: [Binding<MolkkyRound>], title: String) -> some View {
        if (roundsSubset.count > 0) {
            Section(header: Text(title)) {
                ForEach(roundsSubset, id: \.id) { $round in
                    Button(action: {
                        navigationState.activeRoundId = round.id
                        navigationState.isNavigationActive = true
                    }) {
                        CardView(round: round)
                            .deleteDisabled(!(editMode?.wrappedValue.isEditing ?? false))
                    }
                }
                .onDelete(perform: {deleteRound(offsets: $0, list: roundsSubset)})
                .listRowBackground(Color(named: "s.fill.quaternary"))
                // .listRowSeparatorTint(Color(UIColor.secondaryLabel))
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    Divider()
                }
                EditButton()
            }
            .padding(.horizontal, 15)
            List {
                RoundSection(roundsSubset: roundsToday, title: "Today")
                RoundSection(roundsSubset: roundsThisWeek, title: "This week")
                RoundSection(roundsSubset: roundsOlder, title: "Older")
            }
            .scrollContentBackground(.hidden)
            .background(Color(named: "s.background.primary"))
        }
        .onDisappear(perform: {
            if (editMode?.wrappedValue == .active) {
                editMode?.wrappedValue = .inactive
            }
        })
    }
}

struct RoundsView_Previews: PreviewProvider {
    static var previews: some View {
        RoundsView(rounds: .constant([MolkkyRound.sampleData, MolkkyRound.sampleData]))
    }
}
