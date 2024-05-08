//
//  PlayerScoreShimmerView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/24/23.
//

import SwiftUI

struct PlayerScoreShimmerView: View {
    var playerScore: MolkkyRound.ContenderScore
    var currentPlayer: Bool
    
    func getFinishColor() -> Color {
        if (!playerScore.isFinished) {
            return .orange
        } else if (playerScore.finishPosition == 0) {
            return Color(red: 0.99, green: 0.86, blue: 0.36).opacity(0.7)
        } else if (playerScore.finishPosition == 1) {
            return Color(red: 0.7, green: 0.7, blue: 0.7).opacity(0.8)
        } else if (playerScore.finishPosition == 2) {
            return Color(red: 0.7, green: 0.52, blue: 0.27).opacity(0.8)
        } else {
            return .clear
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(getFinishColor())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .allowsHitTesting(false)
            ShimmerBox(show: true)
                .allowsHitTesting(false)
            ZStack {
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .allowsHitTesting(false)
                }
                PlayerScoreView(playerScore: playerScore, currentPlayer: currentPlayer)
                    .blendMode(.destinationOut)
            }
            .compositingGroup()
        }
    }
}

//struct PlayerScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerScoreView()
//    }
//}
