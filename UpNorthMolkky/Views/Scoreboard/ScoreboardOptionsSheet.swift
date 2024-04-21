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
    
    @State var isPresentingEditHistoryView = false
    
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
                Label("End round", systemImage: "flag.checkered")
                    .padding()
                Divider()
                Button(action: {
                    isPresentingEditHistoryView = true;
                }) {
                    Label("Edit previous throws", systemImage: "pencil")
                        .padding()
                        .sheet(isPresented: $isPresentingEditHistoryView) {
                            EditScoreHistorySheet(round: $round, isPresentingEditScoreView: $isPresentingEditHistoryView)
                        }
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
