//
//  AboutView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/3/24.
//

import SwiftUI

struct AboutView: View {
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
                    Text("Version 1.0.0")
                }
            }
        }
        .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
