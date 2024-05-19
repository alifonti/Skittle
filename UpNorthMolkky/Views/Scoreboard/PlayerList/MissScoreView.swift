//
//  MissScoreView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/20/23.
//

import SwiftUI

struct MissScoreView: View {
    let round: MolkkyRound
    var playerScore: MolkkyRound.ContenderScore
    var isSimpleView: Bool
    var displayAccentColor: Color
    
    var numberOfAllowedMisses: Int {
        round.missesForElimination
    }
    var numberOfRecentMisses: Int {
        for (number, element) in playerScore.attempts.reversed().enumerated() {
            if (element.score != 0) {
                if (round.resetInsteadOfEliminate) {
                    // TODO: does this break anything else?
                    return number % round.missesForElimination
                } else {
                    return number
                }
            }
        }
        if (playerScore.attempts.count > 0 && playerScore.attempts[0].score == 0) {
            return playerScore.attempts.count
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                if(numberOfRecentMisses > 0 || !isSimpleView) {
                    ForEach(0..<numberOfRecentMisses, id: \.self) { _ in
                        Image(systemName: "circle.slash")
                            .foregroundColor(Color(UIColor.label))
                            .fixedSize()
                    }
                    ForEach(0 ..< max((numberOfAllowedMisses - numberOfRecentMisses), 0), id: \.self) { _ in
                        Image(systemName: "circle")
                            .foregroundColor(Color(UIColor.secondaryLabel))
                            .fixedSize()
                    }
                }
            }
            if(!isSimpleView) {
                Text("Misses")
                    .font(.body)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }
        }
        .padding([.trailing], 10)
        .fixedSize()
    }
}


struct MissScoreView_Previews: PreviewProvider {
    static var previews: some View {
        MissScoreView(round: MolkkyRound.sampleData, playerScore: (MolkkyRound.ContenderScore(
            player: Contender(name: "A", orderKey: 0),
            attempts: [
                MolkkyRound.ContenderAttempt(player: Contender(name: "A", orderKey: 0), score: 0),
                MolkkyRound.ContenderAttempt(player: Contender(name: "A", orderKey: 0), score: 0)
            ],
            totalScore: 0,
            isInWarning: false,
            isEliminated: false,
            finishPosition: -1
        )), isSimpleView: false, displayAccentColor: Color(UIColor.tintColor))
    }
}
