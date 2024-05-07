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
                        AwardView(awardType: award, names: ["Anthony", "Emma"])
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct AwardView: View {
    let awardType: Award
    let names: [String]
    // let value: Int?
    
    var body: some View {
        switch awardType {
        case Award.maximalist:
            AwardViewTemplate(title: "Maximalist",
                              description: "Awarded to the player with the most 12s",
                              icon: "creditcard",
                              names: names)
        case Award.minimalist:
            AwardViewTemplate(title: "Minimalist",
                              description: "Awarded to the player with the most 1s",
                              icon: "centsign",
                              names: names)
        case Award.unlucky:
            AwardViewTemplate(title: "Unlucky",
                              description: "Awarded to the player with the most misses",
                              icon: "cloud.rain",
                              names: names)
        case Award.spotless:
            AwardViewTemplate(title: "Spotless",
                              description: "Awarded to players with no misses",
                              icon: "bubbles.and.sparkles",
                              names: names)
        case Award.reckless:
            AwardViewTemplate(title: "Reckless",
                              description: "Awarded to the player with the most resets",
                              icon: "exclamationmark.triangle",
                              names: names)
        case Award.efficient:
            AwardViewTemplate(title: "Efficient",
                              description: "Awarded to the player with the highest points per throw average",
                              icon: "leaf",
                              names: names)
        case Award.survivor:
            AwardViewTemplate(title: "Survivor",
                              description: "Awarded to players who escaped elimination",
                              icon: "tent",
                              names: names)
        case Award.soClose:
            AwardViewTemplate(title: "So close!",
                              description: "Awarded to players who finished one point short of the target score",
                              icon: "alarm.waves.left.and.right",
                              names: names)
        case Award.oops:
            AwardViewTemplate(title: "Oops?",
                              description: "Awarded to players who finished with zero points",
                              icon: "zzz",
                              names: names)
        case Award.selective:
            AwardViewTemplate(title: "Selective",
                              description: "Awarded to players who scored three or fewer different values (excluding 0)",
                              icon: "lasso",
                              names: names)
        case Award.variety:
            AwardViewTemplate(title: "Variety",
                              description: "Awarded to players who scored seven or more different values (excluding 0)",
                              icon: "paintpalette",
                              names: names)
        case Award.rainbow:
            AwardViewTemplate(title: "Rainbow Unicorn",
                              description: "Awarded to players who scored all twelve different values (excluding 0)",
                              icon: "rainbow",
                              names: names)
        }
    }
}

struct AwardViewTemplate: View {
    let title: String
    let description: String
    let icon: String
    let names: [String]
    
    let tabShape = UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 20)
    
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
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: 40)
                VStack(alignment: .leading) {
                    Text(title)
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(Color(UIColor.secondaryLabel))
                }
                Spacer()
                Text("50")
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
