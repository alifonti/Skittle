//
//  PlayerOrderView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/4/24.
//

import SwiftUI

struct PlayerOrderView: View {
    @Binding var round: MolkkyRound
    
    @State private var isShuffle: Bool = true
    
    @State private var isDragging = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in 
                self.isDragging = true
                print("dragging")
            }
            .onEnded { _ in
                self.isDragging = false
                print("ended")
            }
    }
    
    var body: some View {
        VStack {
            BarToggleInput(value: $isShuffle, leftLabel: "Set Order", rightLabel: "Random Order")
            .padding(.bottom, 10)
            Divider()
            ScrollView(showsIndicators: false, content: {
                VStack(spacing: 10, content: {
                    ForEach(round.contenders, id: \.self) { contender in
                        PlayerOrderItemView(title: contender.name, index: round.contenders.firstIndex(of: contender) ?? 0,
                            hideOrderedDetails: isShuffle)
                    }
                    Spacer()
                })
            })
        }
        .padding()
    }
}


struct PlayerOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerOrderView(round: .constant(MolkkyRound.sampleData))
    }
}

