//
//  ResultsAwardsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/5/24.
//

import SwiftUI

struct ResultsAwardsView: View {
    let round: MolkkyRound
    
    var awards: [(Award, [Contender], Int?)] {
        MolkkyRound.getPlayerAwards(round: round)
    }
    
    let colors: [Color] = [
        .blue, .green, .orange, .pink, .purple, .brown, .cyan, .mint, .yellow, .red, .indigo, .gray
    ]
    var playerColors: [Contender:Color] {
        Dictionary(round.contenders.enumerated().map({($1, colors[$0 % colors.count])}),
                   uniquingKeysWith: { (first, _) in first })
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(awards, id: \.0) { award in
                        AwardView(award: award.0, names: award.1.map({
                            (UUID(), $0.name, playerColors[$0] ?? .clear)
                        }), count: award.2)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct AwardView: View {
    let award: Award
    let names: [(UUID, String, Color)]
    var count: Int?
    
    let tabShape = UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 20)
    
    var awardInfo: (String, String, String) {
        ResultsAwardsView.getAwardInfo(award: award)
    }
    
    @ViewBuilder
    func PlayerTabView(name: String, color: Color) -> some View {
        Text(name)
            .padding(.vertical, 3)
            .padding(.horizontal, 6)
            .background(
                UnevenRoundedRectangle(topLeadingRadius: 5, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 5)
                    .fill(color.opacity(0.4))
            )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                HStack(spacing: 2) {
                    ForEach(names.sorted(by: {$0.1 < $1.1}), id: \.self.0) { name in
                        PlayerTabView(name: name.1, color: name.2)
                    }
                    Spacer()
                }
            }
            .padding(.leading, 10)
            HStack {
                Image(systemName: awardInfo.2)
                    .font(.title3)
                    .frame(width: 40)
                VStack(alignment: .leading) {
                    Text(awardInfo.0)
                        .fontWeight(.medium)
                    Text(awardInfo.1)
                        .font(.caption)
                }
                Spacer()
                if let count {
                    Text(String(count))
                }
            }
            .padding(.vertical, 20)
            .padding(.leading, 10)
            .padding(.trailing, 15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.1))
            )
        }
    }
}

enum Award: String, CaseIterable, Identifiable {
    case maximalist, minimalist, unlucky, spotless, reckless, efficient,
         survivor, soClose, oops, selective, variety, rainbow
    var id: Self { self }
}

extension ResultsAwardsView {
    static func getAwardInfo(award: Award) -> (title: String, description: String, icon: String) {
        switch award {
        case Award.maximalist:
            return (
                title: "Maximalist",
                description: "Awarded to the player with the most 12s",
                icon: "creditcard"
            )
        case Award.minimalist:
            return (
                title: "Minimalist",
                description: "Awarded to the player with the most 1s",
                icon: "centsign"
            )
        case Award.unlucky:
            return (
                title: "Unlucky",
                description: "Awarded to the player with the most misses",
                icon: "cloud.rain"
            )
        case Award.spotless:
            return (
                title: "Spotless",
                description: "Awarded to players with no misses",
                icon: "bubbles.and.sparkles"
            )
        case Award.reckless:
            return (
                title: "Reckless",
                description: "Awarded to the player with the most resets",
                icon: "exclamationmark.triangle"
            )
        case Award.efficient:
            return (
                title: "Efficient",
                description: "Awarded to the player with the highest points per throw average",
                icon: "leaf"
            )
        case Award.survivor:
            return (
                title: "Survivor",
                description: "Awarded to players who escaped elimination",
                icon: "tent"
            )
        case Award.soClose:
            return (
                title: "So close!",
                description: "Awarded to players who finished one point short of the target score",
                icon: "alarm.waves.left.and.right"
            )
        case Award.oops:
            return (
                title: "Oops?",
                description: "Awarded to players who finished with zero points",
                icon: "zzz"
            )
        case Award.selective:
            return (
                title: "Selective",
                description: "Awarded to players who scored three or fewer different values (excluding 0)",
                icon: "lasso"
            )
        case Award.variety:
            return (
                title: "Variety",
                description: "Awarded to players who scored seven or more different values (excluding 0)",
                icon: "paintpalette"
            )
        case Award.rainbow:
            return (
                title: "Unicorn",
                description: "Awarded to players who scored all twelve different values (excluding 0)",
                icon: "rainbow"
            )
        }
    }
}

struct ResultsAwardsView_Previews: PreviewProvider {
    static var previews: some View {
        var data = MolkkyRound(players: [
            Player(playerName: "A"),
            Player(playerName: "B"),
            Player(playerName: "C"),
            Player(playerName: "D"),
            Player(playerName: "E"),
            Player(playerName: "F"),
            Player(playerName: "G"),
            Player(playerName: "H"),
            Player(playerName: "I"),
            Player(playerName: "J"),
            Player(playerName: "K"),
            Player(playerName: "L"),
        ])
        data.attempts.append(contentsOf: data.contenders.map({
            MolkkyRound.ContenderAttempt(player: $0, score: 1)
        }))
        
        return ResultsAwardsView(round: data)
    }
}
