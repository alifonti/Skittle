//
//  AppPreferencesView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/2/24.
//

import SwiftUI

struct AppPreferencesView: View {
//    @State private var preferredColorScheme: String = UserDefaults.standard.string(forKey: "PreferredColorScheme") ?? "auto"
    @State private var preferDetailedScoreView: Bool = false
    
    @AppStorage("PreferredColorScheme", store: .standard) var preferredColorSchemePreference: String = "auto"
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                ColorSchemePicker()
            }
            Section(header: Text("Scoreboard")) {
                Picker("Default score view", selection: $preferDetailedScoreView) {
                    Text("Simple").tag(false)
                    Text("Detailed").tag(true)
                }
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
