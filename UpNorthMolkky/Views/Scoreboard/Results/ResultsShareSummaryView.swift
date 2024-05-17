//
//  ResultsShareSummaryView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/16/24.
//

import SwiftUI

struct ResultsShareSummaryView: View {
    let round: MolkkyRound
    let results: [(UUID, MolkkyRound.ContenderScore, Int)]
    
    func accentColor(_ position: Int) -> Color {
        if (position == 1) {
            return Color(red: 0.99, green: 0.86, blue: 0.36)
        } else if (position == 2) {
            return Color(red: 0.8, green: 0.8, blue: 0.8)
        } else if (position == 3) {
            return Color(red: 0.9, green: 0.72, blue: 0.47)
        } else {
            return Color(UIColor.label)
        }
    }
    
    var awards: [(Award, [Contender], String?)] {
        MolkkyRound.getPlayerAwards(round: round)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 10) {
                ForEach(results, id: \.0) { result in
                    HStack {
                        HStack {
                            MedalView(finishPosition: result.2, accentColor: accentColor(result.2))
                                .frame(width: 40, alignment: .center)
                            VStack(alignment: .leading) {
                                Text(result.1.contender.name)
                                    .font(.title2)
                                HStack {
                                    ForEach(awards.filter({award in
                                        award.1.contains(where: {contend in
                                            contend.id == result.1.contender.id
                                        })
                                    }), id: \.0) { awardInfo in
                                        Image(systemName: ResultsAwardsView.getAwardInfo(award: awardInfo.0).icon)
                                            .font(.body)
                                            .foregroundStyle(Color(UIColor.secondaryLabel))
                                    }
                                }
                            }
                            Spacer()
                            Text(String(result.1.totalScore))
                                .font(.title)
                        }
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 5)
                            .fill(Color(named: "s.accent1.main").opacity(0.15)))
                    }
                }
            }
            .padding(.all, 15)
            HStack {
                Text(round.date.formatted(date: .abbreviated, time: .shortened))
                    .padding(.trailing, 150)
                Spacer()
                Text("Skittle")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            .foregroundStyle(.white)
            .padding(.all, 10)
            .frame(maxWidth: .infinity)
            .background(
                Rectangle()
                    .fill(Color(named: "s.accent1.main"))
            )
            
        }
        .background(.white)
    }
}

struct TransferablePhoto: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }

    public var image: Image
    public var caption: String
}

struct ResultsShareSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsShareSummaryView(round: MolkkyRound.sampleData, results: [])
    }
}
