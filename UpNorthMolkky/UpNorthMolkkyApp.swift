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
    
    var body: some Scene {
        WindowGroup {
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
        .environmentObject(store)
    }
}

extension Color {
    init(named: String) {
        self.init(uiColor: UIColor(named: named) ?? .clear)
    }
}
