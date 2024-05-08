//
//  MedalView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/25/23.
//

import SwiftUI

struct MedalView : View {
    @Environment(\.colorScheme) var colorScheme
    
    var finishPosition: Int
    var accentColor: Color
    
    var iconString: String {
        "\(finishPosition).circle\(finishPosition <= 3 ? ".fill" : "")"
    }
    
    var isMedal: Bool {
        finishPosition >= 1 && finishPosition <= 3
    }
    
    var body: some View {
        ZStack {
            Image(systemName: iconString)
                .background(isMedal && colorScheme == .light ? Color(UIColor.label) : .clear)
                .foregroundColor(accentColor)
                .font(.title)
                .clipShape(Circle())
            if (isMedal) {
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
