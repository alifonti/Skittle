//
//  PlayTabCard.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/19/24.
//

import SwiftUI

struct PlayTabCard: View {
    var title: String = ""
    var imageName: String = ""
    var buttonLabel: String = ""
    var buttonColor: Color = Color.clear
    var onClick: () -> Void = {}
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: imageName)
            }
            .font(.title2)
            .fontWeight(.medium)
            Button(action: onClick) {
                HStack() {
                    Text(buttonLabel)
                        .accessibilityLabel(buttonLabel)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color(UIColor.quaternarySystemFill))
                .foregroundColor(Color(UIColor.label))
                .font(.headline)
                .fontWeight(.medium)
                .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .padding([.horizontal], 16)
        .padding([.vertical], 18)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.tertiarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}
