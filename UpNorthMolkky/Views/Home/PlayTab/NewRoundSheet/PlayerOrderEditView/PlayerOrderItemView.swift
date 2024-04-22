//
//  PlayerOrderItemView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/4/24.
//

import SwiftUI

struct PlayerOrderItemView: View {
    
    var title: String
    var index: Int
    var hideOrderedDetails: Bool
    
    var body: some View {
        HStack {
            HStack {
                if (!hideOrderedDetails) {
                    Text(String(index + 1))
                        .bold()
                }
                Text(title)
            }
            .padding()
            Spacer()
            if (!hideOrderedDetails) {
                Image(systemName: "chevron.up.chevron.down")
                    .padding()
            }
        }
        .background(Color(UIColor.secondarySystemFill))
        .cornerRadius(5)
    }
}

struct DropViewDelegate: DropDelegate {
    
    let destinationItem: Player
    @Binding var players: [Player]
    @Binding var draggedItem: Player?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if let draggedItem {
            let fromIndex = players.firstIndex(of: draggedItem)
            if let fromIndex {
                let toIndex = players.firstIndex(of: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation {
                        self.players.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                }
            }
        }
    }
}
