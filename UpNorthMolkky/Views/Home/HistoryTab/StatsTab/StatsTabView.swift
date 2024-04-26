//
//  StatsTabView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/25/24.
//

import SwiftUI

struct StatsTabView: View {
    @Binding var userData: SkittleData
    
    var playerStats: [String: [UUID: any Numeric]] {
        userData.getPlayerStats()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Stats")
            }
        }
            
    }
}

struct StatsTabView_Previews: PreviewProvider {
    static var previews: some View {
        StatsTabView(userData: .constant(SkittleData.sampleData))
    }
}
