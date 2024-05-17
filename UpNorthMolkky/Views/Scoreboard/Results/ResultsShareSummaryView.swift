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
    
    var body: some View {
        VStack {
            Text("Results")
            VStack {
                ForEach(results, id: \.0) { result in
                    HStack {
                        Text(String(result.2))
                        Text(result.1.contender.name)
                        Spacer()
                        Text(String(result.1.totalScore))
                    }
                }
            }
            .padding()
            HStack {
                Text(round.date.formatted(date: .abbreviated, time: .shortened))
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
