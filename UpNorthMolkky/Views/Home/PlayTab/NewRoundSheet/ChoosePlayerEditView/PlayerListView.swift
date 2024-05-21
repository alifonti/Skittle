//
//  PlayerListView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/4/24.
//

import SwiftUI
import Combine

struct PlayerListView: View {
    @EnvironmentObject var store: MolkkyStore
    @Binding var round: MolkkyRound
    
    @State private var newPlayerNameText = ""
    @State private var viewAddPlayerField: Bool = false
    @FocusState private var newPlayerIsFocused: Bool
    @State private var searchText = ""
    @FocusState private var searchIsFocused: Bool
    
    let nameTextLimit = 20
    func limitText(_ upper: Int) {
        if newPlayerNameText.count > upper {
            newPlayerNameText = String(newPlayerNameText.prefix(upper))
        }
    }
    
    private var selectedPlayers: [UUID] {
        round.contenders.map{$0.id}
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                        // usernameFieldIsFocused = isEditing
                    }, onCommit: {
                        searchIsFocused = false
                    })
                    .onReceive(Just(newPlayerNameText)) { _ in limitText(nameTextLimit) }
                    .foregroundColor(.primary)
                    .autocorrectionDisabled(true)
                    .focused($searchIsFocused)
                    
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                //
                HStack {
                    Spacer()
                    HStack {
                        Image(systemName: "plus")
                        Text("Add new player")
                    }
                    .padding()
                    Spacer()
                }
                .foregroundStyle(Color(named: "s.accent.foreground"))
                .background(Color(named: "s.accent1.main"))
                .cornerRadius(5)
                .onTapGesture {
                    viewAddPlayerField = true
                    newPlayerIsFocused = true
                }
            }
            .padding()
            //
            VStack(spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(selectedPlayers.count)")
                    Image(systemName: "person.fill.checkmark")
                }
                ScrollView(showsIndicators: false, content: {
                    if (viewAddPlayerField) {
                        HStack {
                            TextField("Add new player", text: $newPlayerNameText)
                                .onSubmit {
                                    if (newPlayerNameText != "") {
                                        // BAD
                                        let newPlayer = Player(playerName: newPlayerNameText)
                                        store.userData.addPlayers([newPlayer])
                                        round.contenders.append(Contender(id: newPlayer.id, name: newPlayer.playerName, orderKey: round.contenders.count))
                                        newPlayerNameText = ""
                                    }
                                    viewAddPlayerField = false
                                }
                                .submitLabel(.done)
                                .padding()
                                .focused($newPlayerIsFocused)
                                .autocorrectionDisabled()
                            Spacer()
                        }
                        .background(Color(UIColor.secondarySystemFill))
                        .cornerRadius(5)
                        .onAppear {
                            newPlayerIsFocused = true
                        }
                        .onDisappear {
                            newPlayerIsFocused = false
                        }
                    }
                    ForEach(store.userData.players
                        .sorted(by: {selectedPlayers.contains($0.id) && !selectedPlayers.contains($1.id)})
                        .filter{$0.playerName.hasPrefix(searchText) || selectedPlayers.contains($0.id) || searchText == ""
                        }, id: \.self) { player in
                            PlayerItemView(player: player, selected: selectedPlayers.contains(player.id))
                                .onTapGesture {
                                    if (selectedPlayers.contains(player.id)) {
                                        round.contenders.remove(at: round.contenders.firstIndex(where: {con in con.id == player.id}) ?? -1)
                                    } else {
                                        round.contenders.append(Contender(id: player.id, name: player.playerName, orderKey: round.contenders.count))
                                    }
                                }
                    }
                    Spacer()
                })
                .padding(.horizontal, 20)
            }
            .animation(.linear(duration: 0.2), value: selectedPlayers)
        }
    }
}


struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView(round: .constant(MolkkyRound.sampleData))
            .environmentObject(MolkkyStore())
    }
}
