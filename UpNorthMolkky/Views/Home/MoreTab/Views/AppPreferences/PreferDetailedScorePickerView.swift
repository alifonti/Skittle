//
//  PreferDetailedScorePickerView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/4/24.
//

import SwiftUI

struct PreferDetailedScorePickerView: View {
    @AppStorage("PreferDetailedScoreView") var preferDetailedScoreView: Bool = false
    
    var body: some View {
        Picker("Default score view", selection: $preferDetailedScoreView) {
            Text("Simple").tag(false)
            Text("Detailed").tag(true)
        }
    }
}

struct PreferDetailedScorePickerView_Previews: PreviewProvider {
    static var previews: some View {
        PreferDetailedScorePickerView()
    }
}
