//
//  ResultsLeaderboardView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/5/24.
//

import SwiftUI

struct ResultsLeaderboardView: View {
    let round: MolkkyRound
    
    var sortedContenders: [MolkkyRound.ContenderScore] {
        // TODO: Don't duplicate this from MolkkyRound
        round.contenderScores.sorted { (lhs, rhs) in
            let predicates: [(MolkkyRound.ContenderScore, MolkkyRound.ContenderScore) -> Bool] = [
                { !$0.isEliminated && $1.isEliminated },
                { $0.totalScore > $1.totalScore },
                { $0.finishPosition < $1.finishPosition },
                { $0.contender.orderKey < $1.contender.orderKey }
            ]
            for predicate in predicates {
                if !predicate(lhs, rhs) && !predicate(rhs, lhs) {
                    continue
                }
                return predicate(lhs, rhs)
            }
            return false
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(sortedContenders) { contenderScore in
                        LeaderboardView(score: contenderScore)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct LeaderboardView: View {
    let score: MolkkyRound.ContenderScore
    
    var body: some View {
        HStack {
            Image(systemName: "\(score.finishPosition + 1).circle")
            Text(score.contender.name)
            Spacer()
            Text(String(score.totalScore))
        }
        .font(.title3)
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 15)
            .fill(Color(named: "s.accent1.main").opacity(0.15)))
    }
}

struct ResultsLeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsLeaderboardView(round: MolkkyRound.sampleData)
    }
}

