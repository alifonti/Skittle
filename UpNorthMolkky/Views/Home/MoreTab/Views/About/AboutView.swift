//
//  AboutView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/3/24.
//

import SwiftUI

struct AboutView: View {
    var releaseVersionNumber: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading) {
                    Text("Skittle")
                        .font(.title)
                        .fontWeight(.semibold)
                }
            }
            HStack {
                Text("Version")
                Spacer()
                Text(releaseVersionNumber ?? "?")
                    .foregroundStyle(Color(UIColor.secondaryLabel))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(named: "s.fill.quaternary"))
            )
            .padding()
            Spacer()
        }
        // .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
