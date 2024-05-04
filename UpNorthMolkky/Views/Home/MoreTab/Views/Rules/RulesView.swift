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
                    Text("Rules")
                        .font(.title)
                    Spacer()
                }
                Text("Paragraph")
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
