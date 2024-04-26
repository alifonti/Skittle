//
//  PlayerDetailsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/6/24.
//

import SwiftUI

struct PlayerDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var userData: SkittleData
    @Binding var player: Player
    var playerRoundCount: Int = 0
    var playerAttemptCount: Int = 0
    var playerAttemptAverage: Double = 0.0
    var playerWinCount: Int = 0
    
    @State private var newValue: String = ""
    @State private var viewNameTextField = false
    @FocusState private var nameFieldIsFocused: Bool
    
    @State private var showingDeletePopover = false
    
    let formatter: DateFormatter = DateFormatter()
    
    var dateString: String {
        let date: Date = player.createTime
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                if (!viewNameTextField) {
                    Text(player.playerName)
                        .font(.largeTitle)
                } else {
                    TextField(player.playerName, text: $newValue, onEditingChanged: { _ in }, onCommit: {
                        if (!newValue.isEmpty) {
                            player.updateName(name: newValue)
                            newValue = ""
                        }
                        viewNameTextField = false
                        nameFieldIsFocused = false
                    })
                    .font(.largeTitle)
                    .fixedSize(horizontal: true, vertical: false)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($nameFieldIsFocused)
                    .onAppear {nameFieldIsFocused = true}
                }
                Button {
                    viewNameTextField = true
                } label: {
                    Image(systemName: "pencil")
                        .font(.title2)
                        .opacity(viewNameTextField ? 0 : 1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Text("Added on \(dateString)")
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 1) {
                HStack {
                    Text("Rounds played:")
                    Spacer()
                    Text("\(playerRoundCount)")
                }
                HStack {
                    Text("Attempts made:")
                    Spacer()
                    Text("\(playerAttemptCount)")
                }
                HStack {
                    Text("Average points per attempt:")
                    Spacer()
                    Text(String(format: "%.1f", playerAttemptAverage))
                }
                HStack {
                    Text("Wins:")
                    Spacer()
                    Text("\(playerWinCount)")
                }
            }
            .padding()
            .background(Color(named: "s.fill.tertiary"))
            Spacer()
            Button("Delete player") {
                showingDeletePopover = true
            }
            .foregroundStyle(.red)
            .alert(
                "Delete \(player.playerName)?",
                isPresented: $showingDeletePopover,
                presenting: player
            ) { player in
                Button(role: .destructive) {
                    userData.removePlayer(player)
                    dismiss()
                } label: {
                    Text("Delete")
                }
            } message: { player in
                Text("This action is permanant.")
            }
        }
        .padding()
    }
}

struct PlayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsView(userData: .constant(SkittleData.sampleData), player: .constant(Player.sampleData[0]), playerRoundCount: 0)
    }
}
