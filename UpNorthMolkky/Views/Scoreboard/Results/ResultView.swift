//
//  ResultView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/4/24.
//

import SwiftUI

struct ScoreboardResultsView: View {
    @State private var isPresenting = true
    var body: some View {
        Button("Present Full-Screen Cover") {
            isPresenting.toggle()
        }
        .fullScreenCover(isPresented: $isPresenting, onDismiss: didDismiss) {
            Group {
                VStack(spacing: 0) {
                    VStack {
                        Text("Results")
                            .font(.title)
                            .foregroundColor(.white)
                        Spacer()
                        HStack {
                            Text("Button")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
                            Text("Button")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    TabView {
                        ResultsLeaderboardView()
                            .ignoresSafeArea(.all, edges: .bottom)
                        ResultsAwardsView()
                            .ignoresSafeArea(.all, edges: .bottom)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30)
                        .fill(Color(UIColor.systemBackground))
                        .ignoresSafeArea(.all, edges: .bottom)
                    )
                }
            }
            .onTapGesture {
                isPresenting.toggle()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all, edges: .bottom)
            .background(Color(named: "s.accent1.main"))
        }
    }


    func didDismiss() {
        // Handle the dismissing action.
    }
}

struct ScoreboardResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardResultsView()
    }
}

