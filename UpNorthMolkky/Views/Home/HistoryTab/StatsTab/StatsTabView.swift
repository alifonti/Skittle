//
//  StatsTabView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/25/24.
//

import SwiftUI

struct Tag: Identifiable, Hashable {
    let id: String
    let string: String
}

struct StatsTabView: View {
    @Binding var userData: SkittleData
    
    var playerStats: [String: Int] {
        userData.getGeneralStats()
    }
    var playerAwards: [UUID: [Award: Int]] {
        userData.getPlayerAwards()
    }
    
    var body: some View {
        VStack(spacing: 15) {
            StatsTabView.StatView(text: "Rounds played",
                                  count: String(playerStats["RoundCount"] ?? 0))
            StatsTabView.StatView(text: "Skittles thrown",
                                  count: String(playerStats["ThrowCount"] ?? 0))
            StatsTabView.StatView(text: "Players added",
                                  count: String(playerStats["PlayerCount"] ?? 0))
            StatsTabView.StatView(text: "Awards earned",
                                  count: String(playerStats["AwardCount"] ?? 0))
            Spacer()
        }
        .padding()
    }
}

extension StatsTabView {
    @ViewBuilder
    static func StatView(text: String, count: String) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(text)
            }
            .font(.title2)
            .fontWeight(.medium)
            Spacer()
            Text(String(count))
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(named: "s.fill.quaternary")))
    }
}

struct StatsTabView_Previews: PreviewProvider {
    static var previews: some View {
        StatsTabView(userData: .constant(SkittleData.sampleData))
    }
}
