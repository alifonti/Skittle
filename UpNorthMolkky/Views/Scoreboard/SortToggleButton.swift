//
//  SortToggleButton.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/23/23.
//

import SwiftUI

struct SortToggleButton: View {
    @Binding var round: MolkkyRound
    
    @State private var isShowingLabel = false
    @State private var timeOfClick: Date = Date()
    
    var body: some View {
        HStack(spacing: 0) {
            if (isShowingLabel) {
                Text(round.sortByTurn ? "Turn Order" : "Points")
                    .font(.subheadline)
                    .transition(.opacity)
            }
            Button(action: {
                withAnimation() {
                    round.toggleSort()
                }
                timeOfClick = Date()
            }) {
                Image(systemName: round.sortByTurn ? "arrow.up.arrow.down.square" : "trophy.circle")
                    .font(.headline)
                    .contentTransition(.symbolEffect(.replace))
            }
            .accessibilityLabel("Sort")
            .onChange(of: timeOfClick) {
                withAnimation(Animation.linear(duration: 0.5).delay(0.2)) {
                    self.isShowingLabel = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if (isShowingLabel && timeOfClick <= Date().addingTimeInterval(-1.9)) {
                        self.isShowingLabel = false
                    }
                }
            }
        }
        .foregroundColor(Color(UIColor.tintColor))
    }
}

extension SortToggleButton {
    struct AdaptiveLabelStyle: LabelStyle {
        @Binding var showLabel: Bool
        func makeBody(configuration: Configuration) -> some View {
            if showLabel {
                HStack {
                    configuration.title
                        .font(.subheadline)
                    configuration.icon
                        .font(.headline)
                }
            } else {
                configuration.icon
                    .font(.headline)
            }
        }
    }
}

struct SortToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        SortToggleButton(round: .constant(MolkkyRound.sampleData))
    }
}
