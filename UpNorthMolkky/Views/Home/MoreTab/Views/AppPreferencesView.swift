//
//  AppPreferencesView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/2/24.
//

import SwiftUI

struct AppPreferencesView: View {
    @State private var preferredColorScheme: PreferredColorScheme =
    UserDefaults.standard.string(forKey: "PreferredColorScheme") ?? "" == PreferredColorScheme.light.rawValue
        ? PreferredColorScheme.light : UserDefaults.standard.string(forKey: "PreferredColorScheme") ?? "" == PreferredColorScheme.dark.rawValue
        ? PreferredColorScheme.dark : PreferredColorScheme.auto
    
    @State private var preferDetailedScoreView: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Picker("Color Scheme", selection: $preferredColorScheme) {
                    ForEach(PreferredColorScheme.allCases) { colorScheme in
                        Text(colorScheme.rawValue.capitalized)
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
        .onChange(of: preferredColorScheme) {
            UserDefaults.standard.set(preferredColorScheme.rawValue, forKey: "PreferredColorScheme")
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
