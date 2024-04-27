//
//  PlayTab.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/18/24.
//

import SwiftUI

struct PlayTabView: View {
    @Binding var userData: SkittleData
    
    @State private var isPresentingNewRoundView = false
    
    var body: some View {
        VStack(spacing: 15) {
            PlayTabCard(variant: .secondary, title: "Rules of the game", imageName: "book", buttonLabel: "View rules")
            PlayTabCard(variant: .primary, title: "Ready to play?", imageName: "play.circle", buttonLabel: "Start a new round", buttonColor: Color(named: "s.accent1.main"),
                onClick: {
                    isPresentingNewRoundView = true
                }
            )
            Spacer()
        }
        .sheet(isPresented: $isPresentingNewRoundView) {
            NewRoundSheet(userData: $userData, isPresentingNewRoundView: $isPresentingNewRoundView)
        }
        .padding()
    }
}

struct PlayTabView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTabView(userData: .constant(SkittleData.sampleData))
    }
}
