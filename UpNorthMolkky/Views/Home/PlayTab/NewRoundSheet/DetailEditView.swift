//
//  DetailEditView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/3/24.
//
import SwiftUI
import TipKit

// Define your tip's content.
struct RoundEditTip: Tip {
    var title: Text {
        Text("Customize your game")
    }

    var message: Text? {
        Text("Slide to view additional tabs for game customization.")
    }

    var image: Image? {
        Image(systemName: "slider.horizontal.2.square.on.square")
    }
}

struct DetailEditView: View {
    @Binding var round: MolkkyRound
    
    var roundEditTip = RoundEditTip()
    
    var body: some View {
        VStack {
            TabView {
                ChoosePlayerEditView(round: $round)
                PlayerOrderEditView(round: $round)
                GameRulesEditView(round: $round)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            TipView(roundEditTip, arrowEdge: .top)
                .padding([.bottom, .leading, .trailing])
        }
    }
}


struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(round: .constant(MolkkyRound.sampleData))
    }
}
