//
//  ResultsAwardsView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/5/24.
//

import SwiftUI

struct ResultsAwardsView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<5) { _ in
                        AwardView()
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct AwardView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "trophy")
                Text("[something creative]")
                Spacer()
            }
            HStack {
                Text("Anthony")
                Spacer()
                Text("50")
            }
        }
        .font(.title3)
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 15)
            .fill(Color.gray.opacity(0.15)))
    }
}

struct ResultsAwardsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsAwardsView()
    }
}
