//
//  ResultsLeaderboardView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/5/24.
//

import SwiftUI

struct ResultsLeaderboardView: View {
    let round: MolkkyRound
    
    var sortedContenders: [(UUID, MolkkyRound.ContenderScore, Int)] {
        var array: [(UUID, MolkkyRound.ContenderScore, Int)] = []
        
        let sorted = round.contenderScores.sorted { (lhs, rhs) in
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
        
        var lastScore: Int = -1
        var lastScoreIndex: Int = 0
        
        for (index, element) in sorted.enumerated() {
            if element.finishPosition >= 0 {
                array.append((UUID(), element, element.finishPosition + 1))
            } else if (element.totalScore != lastScore) {
                array.append((UUID(), element, index + 1))
                lastScore = element.totalScore
                lastScoreIndex = index
            } else {
                array.append((UUID(), element, lastScoreIndex + 1))
            }
        }
        
        return array
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(sortedContenders, id: \.0) { contenderScoreTuple in
                        LeaderboardView(score: contenderScoreTuple.1, position: contenderScoreTuple.2)
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
    let position: Int
    
    // TODO: Reuse code across 2 (3?) locations
    var accentColor: Color {
        if (position == 1) {
            return Color(red: 0.99, green: 0.86, blue: 0.36)
        } else if (position == 2) {
            return Color(red: 0.8, green: 0.8, blue: 0.8)
        } else if (position == 3) {
            return Color(red: 0.9, green: 0.72, blue: 0.47)
        } else {
            return Color(UIColor.label)
        }
    }
    
    var body: some View {
        HStack {
            MedalView(finishPosition: position, accentColor: accentColor)
                .frame(width: 40, alignment: .center)
            Text(score.contender.name)
                .font(.title2)
            Spacer()
            Text(String(score.totalScore))
                .font(.title2)
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

