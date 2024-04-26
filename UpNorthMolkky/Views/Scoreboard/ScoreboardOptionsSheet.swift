//
//  ScoreboardOptionsSheet.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/18/23.
//

import SwiftUI

struct ScoreboardOptionsSheet: View {
    @Binding var round: MolkkyRound
    @Binding var isPresentingOptionsView: Bool
    
    var dismiss: DismissAction
    
    var body: some View {
        NavigationStack {
            ScoreboardOptionsView(round: $round, dismiss: dismiss)
                .navigationTitle("Options")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingOptionsView = false
                        }
                    }
                }
        }
    }
}

struct ScoreboardOptionsView: View {
    @Environment(\.dismiss) private var localDismiss
    @Binding var round: MolkkyRound
    
    var dismiss: DismissAction
    
    var body: some View {
        VStack {
            VStack {
                Divider()
                Button(action: {
                    localDismiss()
                    dismiss()
                }) {
                    Label("Return to menu", systemImage: "house")
                }
                .padding()
                Divider()
                Button(action: {
                    //
                }) {
                    Label("End round early", systemImage: "flag.checkered")
                        .padding()
                }
                Divider()
                Button(action: {
                    //
                }) {
                    Label("Rules Review", systemImage: "book")
                        .padding()
                }
                Divider()
                Button(action: {
                    //
                }) {
                    Label("View Game Settings", systemImage: "gear")
                        .padding()
                }
                Divider()
            }
            Spacer()
        }
    }
}


//struct ScoreboardOptionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreboardOptionsView(isPresentingOptionsView: .constant(true), round: .constant(MolkkyRound.sampleData), )
//    }
//}
