//
//  PlayTabCard.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/19/24.
//

import SwiftUI

struct PlayTabCard: View {
    var variant: Variant = Variant.primary
    var title: String = ""
    var imageName: String = ""
    var buttonLabel: String = ""
    var buttonColor: Color = Color.clear
    var onClick: () -> Void = {}
    
    enum Variant {
        case primary, secondary
    }
    
    var body: some View {
        PlayTabCardBody(variant: variant, title: title, imageName: imageName, buttonLabel: buttonLabel, buttonColor: buttonColor, onClick: onClick)
            .withStyles(variant)
    }
}

struct PlayTabCardBody: View {
    var variant: PlayTabCard.Variant = PlayTabCard.Variant.primary
    var title: String = ""
    var imageName: String = ""
    var buttonLabel: String = ""
    var buttonColor: Color = Color.clear
    var onClick: () -> Void = {}
    
    func withStyles(_ variant: PlayTabCard.Variant) -> some View {
        if (variant == .primary) {
            return self
                .padding([.horizontal], 16)
                .padding([.vertical], 18)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.tertiarySystemFill))
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(UIColor.label), lineWidth: 0)
                )
        } else {
            return self
                .padding([.horizontal], 16)
                .padding([.vertical], 18)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.tertiarySystemFill))
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.gray, lineWidth: 0)
                )
        }
    }
    
    var body: some View {
        VStack {
            PlayTabCardHeader(variant: variant, title: title, imageName: imageName)
                .withStyles(variant)
            Button(action: onClick) {
                PlayTabCardButton(label: buttonLabel, color: buttonColor)
                    .withStyles(variant)
            }
            .padding(.top, 10)
        }
    }
}

struct PlayTabCardHeader: View {
    var variant: PlayTabCard.Variant = PlayTabCard.Variant.primary
    var title: String = ""
    var imageName: String = ""
    
    func withStyles(_ variant: PlayTabCard.Variant) -> some View {
        if (variant == .primary) {
            return self
                .font(.title2)
                .fontWeight(.semibold)
        } else {
            return self
                .font(.title2)
                .fontWeight(.medium)
        }
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: imageName)
        }
    }
}

struct PlayTabCardButton: View {
    var label: String = ""
    var color: Color = Color.clear
    
    func withStyles(_ variant: PlayTabCard.Variant) -> some View {
        if (variant == .primary) {
            return self
                .background(color)
                .foregroundColor(Color(UIColor.white))
                .font(.headline)
                .fontWeight(.medium)
                .cornerRadius(10)
        } else {
            return self
                .background(Color(UIColor.quaternarySystemFill))
                .foregroundColor(Color(UIColor.label))
                .font(.headline)
                .fontWeight(.medium)
                .cornerRadius(10)
        }
    }
    
    var body: some View {
        HStack() {
            Text(label)
                .accessibilityLabel(label)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

