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
    
//    init(rounds: Binding<[MolkkyRound]>) {
//        self._rounds = rounds
//    }
    
//    func srtDates(a: Binding<MolkkyRound>, b: Binding<MolkkyRound>) {
//        .sorted(by: {a, b in
//            a.wrappedValue.date > b.wrappedValue.date
//        })
//    }
    func deleteRound(offsets: IndexSet, list: [Binding<MolkkyRound>]) {
        for offset in offsets {
            if let index = rounds.firstIndex(where: {$0 == list[offset].wrappedValue}) {
                rounds.remove(at: index)
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
                if (roundsToday.count > 0) {
                    Section(header: Text("Today")) {
                        ForEach(roundsToday, id: \.id) { $round in
                            Button(action: {
                                navigationState.activeRoundId = round.id
                                navigationState.isNavigationActive = true
                            }) {
                                CardView(round: round)
                                    .deleteDisabled(!(editMode?.wrappedValue.isEditing ?? false))
                            }
                        }
                        .onDelete(perform: {deleteRound(offsets: $0, list: roundsToday)})
                        .listRowBackground(Color(named: "s.fill.quaternary"))
                        .listRowSeparatorTint(Color(UIColor.secondaryLabel))
                    }
                }
                if (roundsThisWeek.count > 0) {
                    Section(header: Text("This week")) {
                        ForEach(roundsThisWeek, id: \.id) { $round in
                            Button(action: {
                                navigationState.activeRoundId = round.id
                                navigationState.isNavigationActive = true
                            }) {
                                CardView(round: round)
                                    .deleteDisabled(!(editMode?.wrappedValue.isEditing ?? false))
                            }
                        }
                        .onDelete(perform: {deleteRound(offsets: $0, list: roundsThisWeek)})
                        .listRowBackground(Color(named: "s.fill.quaternary"))
                        .listRowSeparatorTint(Color(UIColor.secondaryLabel))
                        
                    }
                }
                if (roundsOlder.count > 0) {
                    Section(header: Text("Older")) {
                        ForEach(roundsOlder, id: \.id) { $round in
                            Button(action: {
                                navigationState.activeRoundId = round.id
                                navigationState.isNavigationActive = true
                            }) {
                                CardView(round: round)
                                    .deleteDisabled(!(editMode?.wrappedValue.isEditing ?? false))
                            }
                        }
                        .onDelete(perform: {deleteRound(offsets: $0, list: roundsOlder)})
                        .listRowBackground(Color(named: "s.fill.quaternary"))
                        .listRowSeparatorTint(Color(UIColor.secondaryLabel))
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(named: "s.background.primary"))
        }
    }
}

struct RoundsView_Previews: PreviewProvider {
    static var previews: some View {
        RoundsView(rounds: .constant([MolkkyRound.sampleData, MolkkyRound.sampleData]))
    }
}
