//
//  ContentView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/12/23.
//

import SwiftUI

struct PlayerScoresListView: View {
    @Binding var round: MolkkyRound
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(round.contenderScores, id: \.contender.id) { contenderScore in
                    VStack(spacing: 0) {
                        Divider()
                        PlayerScoreView(
                            round: round,
                            playerScore: contenderScore,
                            currentPlayer: (round.currentContenderIndex == contenderScore.contender.orderKey) && !round.hasGameEnded
                        )
                    }
                }
                Divider()
            }
        }
        .background(Color(named: "s.background.primary"))
    }
}

struct PlayerScoresListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerScoresListView(round: .constant(MolkkyRound.sampleData))
    }
}
