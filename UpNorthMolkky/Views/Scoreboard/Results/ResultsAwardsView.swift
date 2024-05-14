//
//  ResultsAwardsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/5/24.
//

import SwiftUI

struct ResultsAwardsView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(Award.allCases) { award in
                        AwardView(award: award, names: ["Anthony", "Emma"])
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
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
struct AwardView: View {
    let award: Award
    let names: [String]
    var count: Int?
    
    let tabShape = UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 20)
    
    var awardInfo: (String, String, String) {
        ResultsAwardsView.getAwardInfo(award: award)
    }
    
    @ViewBuilder
    func PlayerTabView(name: String) -> some View {
        Text(name)
            .padding(.vertical, 3)
            .padding(.horizontal, 6)
            .background(
                UnevenRoundedRectangle(topLeadingRadius: 5, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 5)
                    .fill(Color.orange.opacity(0.4))
            )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                ForEach(names, id: \.self) { name in
                    PlayerTabView(name: name)
                }
                Spacer()
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
            .padding(.horizontal, 10)
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

struct ResultsAwardsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsAwardsView()
    }
}
