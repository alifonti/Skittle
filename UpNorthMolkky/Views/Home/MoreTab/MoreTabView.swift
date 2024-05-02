//
//  MoreTabView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/1/24.
//

import SwiftUI

struct MoreTabView: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                MoreTabViewListTitle(title: "Customize")
                MoreTabViewListItem(text: "App preferences", image: "gear")
            }
            VStack {
                MoreTabViewListTitle(title: "Reference")
                MoreTabViewListItem(text: "Rules of the game", image: "book")
                MoreTabViewListItem(text: "Skittle tips", image: "lightbulb")
            }
            VStack {
                MoreTabViewListTitle(title: "Information")
                MoreTabViewListItem(text: "Provide feedback", image: "star.bubble")
                MoreTabViewListItem(text: "App information", image: "info.circle")
            }
            VStack {
                MoreTabViewListTitle(title: "Data")
                MoreTabViewListItem(text: "Clear app data", image: "trash")
            }
            Spacer()
        }
        .padding()
    }
}

struct MoreTabViewListItem: View {
    let text: String
    let image: String
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: image)
                .frame(width: 40)
            Text(text)
            Spacer()
            Image(systemName: "chevron.forward")
        }
        .padding(.vertical, 10)
    }
}

struct MoreTabViewListTitle: View {
    let title: String
    var body: some View {
        VStack(spacing: 5) {
            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            Divider()
        }
    }
}

struct MoreTabView_Previews: PreviewProvider {
    static var previews: some View {
        MoreTabView()
    }
}
