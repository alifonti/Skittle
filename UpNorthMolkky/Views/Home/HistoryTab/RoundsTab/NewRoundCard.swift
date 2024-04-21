//
//  NewRoundCard.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 10/4/23.
//

import SwiftUI

struct NewRoundCard: View {
    var body: some View {
        HStack() {
            Label("New round", systemImage: "plus")
                .font(.headline)
                .foregroundColor(Color(UIColor.white))
                .accessibilityLabel("New Round")
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}
