//
//  HistoryAwardView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/13/24.
//

import SwiftUI

struct HistoryAwardView: View {
    let backgroundShape = RoundedRectangle(cornerRadius: 10)
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                ForEach(Award.allCases) { award in
                    CompactAwardView(award: award, count: 0)
                    Divider()
                }
            }
        }
        .background(backgroundShape.fill(Color(named: "s.fill.quaternary")))
        .clipShape(backgroundShape)
    }
}

struct CompactAwardView: View {
    let award: Award
    var count: Int
    
    var awardInfo: (String, String, String) {
        ResultsAwardsView.getAwardInfo(award: award)
    }
    
    var body: some View {
        HStack {
            Image(systemName: awardInfo.2)
                .frame(width: 40, alignment: .leading)
            VStack(alignment: .leading) {
                Text(awardInfo.0)
            }
            Spacer()
            Text(String(count))
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
    }
}

struct HistoryAwardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryAwardView()
    }
}
