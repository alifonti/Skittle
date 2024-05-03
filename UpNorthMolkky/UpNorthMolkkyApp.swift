//
//  UpNorthMolkkyApp.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/12/23.
//

import SwiftUI
import TipKit

@main
struct UpNorthMolkkyApp: App {
    @StateObject private var store = MolkkyStore()
    @State private var errorWrapper: ErrorWrapper?
    
    @AppStorage("PreferredColorScheme", store: .standard) var preferredColorSchemePreference: String = ""
    
    var preferredColorScheme: ColorScheme? {
        if (preferredColorSchemePreference == AppPreferencesView.PreferredColorScheme.light.rawValue) {
            return .light
        } else if (preferredColorSchemePreference == AppPreferencesView.PreferredColorScheme.dark.rawValue) {
            return .dark
        } else {
            return nil
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                HomeView() {
                    Task {
                        do {
                            try await store.save(data: store.userData)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
                .task {
                    // Configure and load your tips at app launch.
                    try? Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Molkky will load sample data and continue.")
                    }
                }
                .sheet(item: $errorWrapper) {
                    store.userData = SkittleData()
                } content: { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
            }
            .preferredColorScheme(preferredColorScheme)
        }
        .environmentObject(store)
    }
}

extension Color {
    init(named: String) {
        self.init(uiColor: UIColor(named: named) ?? .clear)
    }
}
