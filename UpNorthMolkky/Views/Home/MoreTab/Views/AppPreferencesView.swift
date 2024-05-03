//
//  AppPreferencesView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/2/24.
//

import SwiftUI

struct AppPreferencesView: View {
    @State private var preferredColorScheme: String = UserDefaults.standard.string(forKey: "PreferredColorScheme") ?? "auto"
    @State private var preferDetailedScoreView: Bool = false
    
    @AppStorage("PreferredColorScheme", store: .standard) var preferredColorSchemePreference: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Picker("Color Scheme", selection: $preferredColorSchemePreference) {
                    ForEach(PreferredColorScheme.allCases) { colorScheme in
                        Text(colorScheme.rawValue.capitalized).tag(colorScheme.rawValue)
                    }
                }
            }
            Section(header: Text("Scoreboard")) {
                Picker("Default score view", selection: $preferDetailedScoreView) {
                    Text("Simple").tag(false)
                    Text("Detailed").tag(true)
                }
            }
        }
        .navigationTitle("Preferences")
        .onChange(of: preferredColorScheme) {
            UserDefaults.standard.set(preferredColorScheme, forKey: "PreferredColorScheme")
        }
    }
}

extension AppPreferencesView {
    enum PreferredColorScheme: String, CaseIterable, Identifiable {
        case auto, light, dark
        var id: Self { self }
    }
    
    func parsePreferredColorScheme(_ colorScheme: String) -> PreferredColorScheme {
        if (colorScheme == PreferredColorScheme.light.rawValue) {
            return .light
        } else if (colorScheme == PreferredColorScheme.dark.rawValue) {
            return .dark
        } else {
            return .auto
        }
    }
}

struct AppPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        AppPreferencesView()
    }
}
