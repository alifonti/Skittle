//
//  CardView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/16/23.
//

import SwiftUI

struct CardView: View {
    let round: MolkkyRound
    
    var headerDetails: (String, String) {
        let results: [(UUID, MolkkyRound.ContenderScore, Int)] = MolkkyRound.getSortedResults(round: round)
        if let winner = results.first(where: {$0.2 == 1}) {
            if (round.hasGameEnded) {
                return ("crown", winner.1.contender.name)
            }
        }
        return ("pause.circle", "In progress")
    }
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: headerDetails.0)
                Text(headerDetails.1)
                    .accessibilityAddTraits(.isHeader)
            }
            .font(.title2)
            Spacer()
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "person.3.fill")
                    Text(String(round.contenders.count))
                }
                Spacer()
                HStack(alignment: .firstTextBaseline) {
                    Text("\(round.date.formatted(date: .abbreviated, time: .omitted))")
                        .accessibilityLabel("Round \(round.date.formatted(date: .abbreviated, time: .shortened))")
                }
            }
            .font(.callout)
        }
        .padding(.vertical, 15)
        .foregroundColor(Color(uiColor: .label))
        .alignmentGuide(.listRowSeparatorLeading) { d in
            d[.leading]
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var round = MolkkyRound.sampleData
    static var previews: some View {
        VStack {
            // Spacer()
            CardView(round: round)
                .fixedSize(horizontal: true, vertical: true)
            Spacer()
        }
    }
}
