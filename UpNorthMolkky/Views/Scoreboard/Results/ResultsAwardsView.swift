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
    
    let tabShape = UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 20)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                Text("Anthony")
                    .padding(.vertical, 3)
                    .padding(.horizontal, 6)
                    .background(
                        UnevenRoundedRectangle(topLeadingRadius: 5, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 5)
                            .fill(Color.orange.opacity(0.4))
                    )
                Text("Emma")
                    .padding(.vertical, 3)
                    .padding(.horizontal, 6)
                    .background(
                        UnevenRoundedRectangle(topLeadingRadius: 5, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 5)
                            .fill(Color.green.opacity(0.4))
                    )
                Spacer()
            }
            .padding(.leading, 10)
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
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.15))
            )
        }
    }
}

struct ResultsAwardsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsAwardsView()
    }
}
