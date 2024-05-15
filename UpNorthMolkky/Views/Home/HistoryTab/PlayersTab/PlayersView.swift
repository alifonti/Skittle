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
        List {
            ForEach($userData.players, id: \.id) { $player in
                NavigationLink(destination: PlayerDetailsView(userData: $userData, player: $player,
                                                  playerRoundCount: playerRoundsCount[player.id] ?? 0,
                                                  playerAttemptCount: playerAttemptCount[player.id] ?? 0,
                                                  playerAttemptAverage: playerAttemptAverages[player.id] ?? 0,
                                                  playerWinCount: playerWinCount[player.id] ?? 0)) {
                    HStack {
                        Text(player.playerName)
                        Spacer()
                        Text("\(playerRoundsCount[player.id] ?? 0) games played")
                            .foregroundStyle(Color(UIColor.secondaryLabel))
                    }
                }
            }
            .listRowBackground(Color(named: "s.fill.tertiary"))
        }
        .scrollContentBackground(.hidden)
        .background(Color(named: "s.background.primary"))
    }
}

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(userData: .constant(SkittleData.sampleData))
    }
}
