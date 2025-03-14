//
//  PlayersView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/6/24.
//

import SwiftUI

struct PlayersView: View {
    @Binding var userData: SkittleData
    
    var playerStats: [String: [UUID: any Numeric]] {
        userData.getPlayerStats()
    }
    
    var playerAwards: [UUID: [Award: Int]] {
        userData.getPlayerAwards()
    }
    
    var playerRoundsCount: [UUID: Int] {
        (playerStats["RoundCount"] ?? [:]) as? [UUID: Int] ?? [:]
    }
    var playerAttemptCount: [UUID: Int] {
        (playerStats["AttemptCount"] ?? [:]) as? [UUID: Int] ?? [:]
    }
    var playerAttemptAverages: [UUID: Double] {
        (playerStats["AttemptAverage"] ?? [:]) as? [UUID: Double] ?? [:]
    }
    var playerWinCount: [UUID: Int] {
        (playerStats["WinCount"] ?? [:]) as? [UUID: Int] ?? [:]
    }
    
    var body: some View {
        if (userData.players.count > 0) {
            List {
                Section(header: Text("Players")) {
                    ForEach($userData.players.sorted(by: {
                        playerRoundsCount[$0.id] ?? 0 >
                        playerRoundsCount[$1.id] ?? 0
                    }), id: \.id) { $player in
                        NavigationLink(destination: PlayerDetailsView(userData: $userData, player: $player,
                                                                      playerRoundCount: playerRoundsCount[player.id] ?? 0,
                                                                      playerAttemptCount: playerAttemptCount[player.id] ?? 0,
                                                                      playerAttemptAverage: playerAttemptAverages[player.id] ?? 0,
                                                                      playerWinCount: playerWinCount[player.id] ?? 0, awards: playerAwards[player.id] ?? [:])) {
                            HStack {
                                Text(player.playerName)
                                Spacer()
                                Text("\(playerRoundsCount[player.id] ?? 0) games played")
                                    .foregroundStyle(Color(UIColor.secondaryLabel))
                            }
                        }
                    }
                    .listRowBackground(Color(named: "s.fill.quaternary"))
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(named: "s.background.primary"))
        } else {
            VStack(spacing: 20) {
                Image(systemName: "figure.2")
                    .font(.largeTitle)
                Group {
                  Text("Go to the ") +
                  Text("Play")
                        .foregroundStyle(Color(named: "s.accent1.main"))
                        .fontWeight(.medium) +
                  Text(" tab to start a new round!")
                }
            }
        }
    }
}

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(userData: .constant(SkittleData.sampleData))
    }
}
