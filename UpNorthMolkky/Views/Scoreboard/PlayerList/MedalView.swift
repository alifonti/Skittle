//
//  MedalView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/25/23.
//

import SwiftUI

struct MedalView : View {
    @Environment(\.colorScheme) var colorScheme
    
    var playerScore: MolkkyRound.PlayerScore
    var accentColor: Color
    
    var iconString: String {
        "\(playerScore.finishPosition + 1).circle\(playerScore.finishPosition <= 2 ? ".fill" : "")"
    }
    var isMedal: Bool {
        playerScore.finishPosition >= 0 && playerScore.finishPosition <= 2
    }
    
    var body: some View {
        ZStack {
            Image(systemName: iconString)
                .background(isMedal && colorScheme == .light ? Color(UIColor.label) : .clear)
                .foregroundColor(accentColor)
                .font(.title)
                .clipShape(Circle())
            if(isMedal) {
                ShimmerBox(show: true)
                    .allowsHitTesting(false)
                    .mask(
                        Image(systemName: iconString)
                            .font(.title)
                    )
            }
        }
    }
}
