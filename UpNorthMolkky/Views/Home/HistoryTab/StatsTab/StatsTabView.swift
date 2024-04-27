//
//  StatsTabView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/25/24.
//

import SwiftUI

struct StatsTabView: View {
    @Binding var userData: SkittleData
    
    var playerStats: [String: Int] {
        userData.getGeneralStats()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Rounds played:")
                Spacer()
                Text("\(playerStats["RoundCount"] ?? 0)")
            }
            HStack {
                Text("Unique players:")
                Spacer()
                Text("\(playerStats["PlayerCount"] ?? 0)")
            }
            HStack {
                Text("Number of attempts:")
                Spacer()
                Text("\(playerStats["TotalThrows"] ?? 0)")
            }
            Spacer()
        }
        .padding()
    }
}

struct StatsTabView_Previews: PreviewProvider {
    static var previews: some View {
        StatsTabView(userData: .constant(SkittleData.sampleData))
    }
}
