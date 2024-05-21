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
            HStack(alignment: .center) {
                if (!hideOrderedDetails) {
                    Image(systemName: "\(String(index + 1)).square.fill")
                        .font(.title2)
                        .foregroundStyle(Color(named: "s.accent1.main"))
                }
                Text(title)
                    .font(.title2)
            }
            Spacer()
//            if (!hideOrderedDetails) {
//                Image(systemName: "chevron.up.chevron.down")
//            }
        }
        .padding(.all, 20)
        .alignmentGuide(.listRowSeparatorLeading) { d in
            d[.leading]
        }
        .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
    }
}
