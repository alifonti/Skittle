//
//  PlayTabCard.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/19/24.
//

import SwiftUI

struct RulesPlayTabCard: View {
    var body: some View {
        VStack {
            HStack {
                Text("Rules of the game")
                Spacer()
                Image(systemName: "book")
            }
            .font(.title2)
            .fontWeight(.medium)
            NavigationLink(destination: RulesView()) {
                HStack() {
                    Text("View rules")
                        .accessibilityLabel("View rules")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color(UIColor.tertiarySystemFill))
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
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color(named: "s.fill.quaternary"))
                .shadow(radius: 2, x: 0, y: 2)
        )
    }
}

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
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color(named: "s.fill.quaternary"))
                .shadow(radius: 2, x: 0, y: 2)
        )
    }
}

struct RoundInProgressCard: View {
    @EnvironmentObject var navigationState: NavigationState
    
    var primaryOnClick: () -> Void = {}
    @Binding var latestGame: MolkkyRound
    
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
                        Label("\(latestGame.date.formatted(date: .numeric, time: .shortened))", systemImage: "clock")
                        Label("\(latestGame.contenders.count)", systemImage: "person.2")
                    }
                }
            }
            Button(action: {
                navigationState.activeRoundId = latestGame.id
                navigationState.isNavigationActive = true
            }) {
                HStack() {
                    Text("Continue round")
                        .accessibilityLabel("Continue round in progress")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color(named: "s.accent1.main"))
                .foregroundColor(Color(named: "s.accent.foreground"))
                .font(.headline)
                .fontWeight(.semibold)
                .cornerRadius(10)
            }
            .padding(.top, 10)
            Button(action: primaryOnClick) {
                HStack() {
                    Text("Start a new round")
                        .accessibilityLabel("Start new round")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color(UIColor.tertiarySystemFill))
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
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color(named: "s.fill.quaternary"))
                .shadow(radius: 2, x: 0, y: 2)
        )
    }
}

struct MainPlayCard: View {
    var newGameOnClick: () -> Void = {}
    @Binding var rounds: [MolkkyRound]
    
    var body: some View {
        let showInProgress: Bool = $rounds.count > 0 && !$rounds[$rounds.count - 1].wrappedValue.hasGameEnded
        
        // Hack: Persist the in-progress card so that binding isn't lost on round completion
        ZStack(alignment: .top) {
            if ($rounds.count > 0) {
                RoundInProgressCard(primaryOnClick: newGameOnClick, latestGame: $rounds[$rounds.count - 1])
                    .opacity(showInProgress ? 1 : 0)
            }
            GenericPlayTabCard(title: "Ready to play?", imageName: "play.circle",
                               buttonLabel: "Start a new round", buttonColor: Color(named: "s.accent1.main"),
                               buttonLabelColor: Color(named: "s.accent.foreground"), onClick: newGameOnClick)
                .opacity(!showInProgress ? 1 : 0)
        }
    }
}
