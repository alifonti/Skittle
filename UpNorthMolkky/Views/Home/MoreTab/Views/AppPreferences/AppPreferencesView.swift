//
//  AppPreferencesView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/2/24.
//

import SwiftUI

struct AppPreferencesView: View {
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                ColorSchemePicker()
            }
            Section(header: Text("Scoreboard")) {
                PreferDetailedScorePickerView()
            }
        }
        .navigationTitle("Preferences")
    }
}

struct AppPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        AppPreferencesView()
    }
}
