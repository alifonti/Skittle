//
//  RulesView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/2/24.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        Group {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Equipment")
                                .font(.title)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        Text("\u{2022} 12 pins, numbered from 1 to 12")
                        Text("\u{2022} Throwing skittle")
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Setup")
                                .font(.title)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            FormationView()
                            Spacer()
                        }
                        Text("Place the twelve numbered pins in the formation pictured above. Draw the throwing line about 3-4 meters (10-13 feet) away from the numbered pins.")
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("How to play")
                                .font(.title)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        Text("All players take turns trying to knock down the numbered pins with the throwing skittle. The skittle must be thrown underhand and from behind the throwing line.")
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Objective")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        Text("The first player to score exactly 50 points is the winner.")
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Scoring")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        Text("If a single pin is knocked down, the player earns points equal to the number on the pin.")
                        Group {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Example")
                                            .italic()
                                        Text("Only").fontWeight(.semibold) +
                                        Text(" the 11 pin is knocked down = 11 points")
                                    }
                                    Spacer()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.all, 15)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                        }
                        .padding(.leading, 10)
                        Text("If multiple pins are knocked down, the player earns one point for each fallen pin.")
                        Group {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Example")
                                            .italic()
                                        Text("4 pins knocked down = 4 points")
                                    }
                                    Spacer()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.all, 15)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                        }
                        .padding(.leading, 10)
                        Text("After scoring, fallen pins are placed upright in the location that they came to rest.")
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Fallen pin")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        Text("A pin is considered fallen if it is lying enitrely on the surface. If a pin is resting on either another pin or the throwing skittle, it is not considered fallen. All pins are place upright after scoring, regardless of it it was considered fallen or not.")
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Elimination")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        Text("If a player fails to knock down a pin on three consecutive turns, they are eliminated from the game.")
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Reset / \"Bust\"")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        Text("If a player scores more than 50 points, their score is set to 25.")
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Rules")
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
