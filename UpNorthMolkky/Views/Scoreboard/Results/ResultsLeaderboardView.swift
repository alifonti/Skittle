//
//  ResultsLeaderboardView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/5/24.
//

import SwiftUI

struct ResultsLeaderboardView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<10) { _ in
                        LeaderboardView()
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct LeaderboardView: View {
    var body: some View {
        HStack {
            Image(systemName: "1.circle")
            Text("Name")
            Spacer()
            Text("50")
        }
        .font(.title3)
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 15)
            .fill(Color(named: "s.accent1.main").opacity(0.15)))
    }
}

struct ResultsLeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsLeaderboardView()
    }
}

