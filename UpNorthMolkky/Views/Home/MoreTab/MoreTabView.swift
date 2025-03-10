//
//  MoreTabView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/1/24.
//

import SwiftUI

struct MoreTabView: View {
    @Environment(\.openURL) private var openURL
    @EnvironmentObject var store: MolkkyStore
    
    @State private var showingDeleteDataPopover = false
    
    func openReviewUrl() {
        let url = "https://apps.apple.com/app/id00000000?action=write-review"
        guard let writeReviewURL = URL(string: url) else {
            fatalError("Expected a valid URL")
        }
        openURL(writeReviewURL)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 5) {
                MoreTabViewListTitle(title: "Customize")
                NavigationLink(destination: AppPreferencesView()) {
                    MoreTabViewListItem(text: "App preferences", image: "gear")
                }
            }
            VStack(spacing: 5) {
                MoreTabViewListTitle(title: "Reference")
                NavigationLink(destination: RulesView()) {
                    MoreTabViewListItem(text: "Game rules", image: "book")
                }
            }
            VStack(spacing: 5) {
                MoreTabViewListTitle(title: "Application")
                Button(action: openReviewUrl) {
                    MoreTabViewListItem(text: "Review Skittle", image: "star.bubble")
                }
                NavigationLink(destination: AboutView()) {
                    MoreTabViewListItem(text: "About", image: "info.circle")
                }
            }
            VStack(spacing: 5) {
                MoreTabViewListTitle(title: "Data")
                Button(action: {showingDeleteDataPopover = true}) {
                    MoreTabViewListItem(text: "Clear app data", image: "trash")
                        .alert(
                            "Delete all data?",
                            isPresented: $showingDeleteDataPopover
                        ) {
                            Button(role: .destructive) {
                                store.userData.resetUserData()
                            } label: {
                                Text("Delete")
                            }
                        } message: {
                            Text("This action is permanant.")
                        }
                }
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
        .foregroundStyle(Color(UIColor.label))
        .padding(.vertical, 12)
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
                    .foregroundStyle(Color(UIColor.secondaryLabel))
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
