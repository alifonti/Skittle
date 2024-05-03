//
//  PlayTabCard.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/19/24.
//

import SwiftUI

struct GenericPlayTabCard: View {
    var title: String = ""
    var imageName: String = ""
    var buttonLabel: String = ""
    var buttonColor: Color = Color.clear
    var buttonLabelColor: Color = Color.clear
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
                .background(buttonColor)
                .foregroundColor(buttonLabelColor)
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

struct RoundInProgressCard: View {
    var primaryOnClick: () -> Void = {}
    var secondaryOnClick: () -> Void = {}
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Round in progress")
                            .font(.title2)
                            .fontWeight(.medium)
                        Spacer()
                        Image(systemName: "pause.circle")
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    HStack {
                        Label("\(Date().formatted(date: .numeric, time: .shortened))", systemImage: "clock")
                        Label("2", systemImage: "person.2")
                    }
                }
            }
            Button(action: primaryOnClick) {
                HStack() {
                    Text("Continue round")
                        .accessibilityLabel("Continue round in progress")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color(named: "s.accent1.main"))
                .foregroundColor(Color(UIColor.white))
                .font(.headline)
                .fontWeight(.semibold)
                .cornerRadius(10)
            }
            .padding(.top, 10)
            Button(action: secondaryOnClick) {
                HStack() {
                    Text("Start a new round")
                        .accessibilityLabel("Start new round")
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

