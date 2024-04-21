//
//  CardView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/16/23.
//

import SwiftUI

struct CardView: View {
    let round: MolkkyRound
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Round")
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                Spacer()
                Label("\(round.players.count)", systemImage: "person.3")
                    .accessibilityLabel("\(round.players.count) attendees")
                    .font(.caption)
            }
            Spacer()
            VStack {
                Label("\(round.date.formatted(date: .abbreviated, time: .shortened))", systemImage: "calendar")
                    .accessibilityLabel("Round \(round.date.formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption)
            }
        }
        .padding()
        .foregroundColor(Color(uiColor: .label))
    }
}


struct CardView_Previews: PreviewProvider {
    static var round = MolkkyRound.sampleData
    static var previews: some View {
        CardView(round: round)
            .background()
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
