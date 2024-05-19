//
//  RulesView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/2/24.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                HStack {
                    Text("Set up")
                        .font(.title2)
                    Spacer()
                }
                Text("Paragraph")
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Rules")
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
