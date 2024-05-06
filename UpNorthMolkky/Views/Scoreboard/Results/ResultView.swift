//
//  ResultView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/4/24.
//

import SwiftUI
import ConfettiSwiftUI

struct ScoreboardResultsView: View {
    @State private var isPresenting = true
    @State private var confettiAnimationCounter = 0
    
    @State var selectedTab: ScoreboardResultsView.Tab = ScoreboardResultsView.Tab.leaderboard
    
    let tabShape = UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 20)
    
    var body: some View {
        Button("Present Full-Screen Cover") {
            isPresenting.toggle()
        }
        .fullScreenCover(isPresented: $isPresenting, onDismiss: didDismiss) {
            Group {
                VStack(spacing: 0) {
                    VStack {
                        Spacer()
                        Text("[player] wins!")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Spacer()
                        EmptyView()
                            .confettiCannon(counter: $confettiAnimationCounter, num: 60, rainHeight: 1500, radius: 600)
                            .onAppear { confettiAnimationCounter += 1 }
                        HStack {
                            Text("Play again")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
                            Text("Continue")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {
                        HStack {
                            Button(action: {withAnimation{selectedTab = ScoreboardResultsView.Tab.leaderboard}}) {
                                Text("Leaderboard")
                                    .font(.title2)
                                    .foregroundStyle(selectedTab == ScoreboardResultsView.Tab.leaderboard ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                            }
                            Spacer()
                            Button(action: {withAnimation{selectedTab = ScoreboardResultsView.Tab.awards}}) {
                                Text("Awards")
                                    .font(.title2)
                                    .foregroundStyle(selectedTab == ScoreboardResultsView.Tab.awards ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                            }
                        }
                        .padding(.top, 25)
                        .padding(.bottom, 10)
                        .padding(.horizontal, 20)
                        .background(
                            ZStack {
                                tabShape
                                    .fill(Color(UIColor.gray).opacity(0.2))
                                Group {
                                    tabShape
                                        .fill(Color(UIColor.systemBackground))
                                }
                                .padding(.trailing, 195)
                                .shadow(radius: 5, x: 0, y: 0)
                                .opacity(selectedTab == ScoreboardResultsView.Tab.leaderboard ? 1 : 0)
                                Group {
                                    tabShape
                                        .fill(Color(UIColor.systemBackground))
                                }
                                .padding(.leading, 205)
                                .shadow(radius: 5, x: 0, y: 0)
                                .opacity(selectedTab == ScoreboardResultsView.Tab.awards ? 1 : 0)
                            }.clipShape(tabShape)
                        )
                        TabView(selection: $selectedTab) {
                            ResultsLeaderboardView()
                                .tag(ScoreboardResultsView.Tab.leaderboard)
                                .ignoresSafeArea(.all, edges: .bottom)
                            ResultsAwardsView()
                                .tag(ScoreboardResultsView.Tab.awards)
                                .ignoresSafeArea(.all, edges: .bottom)
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .background(tabShape
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

extension ScoreboardResultsView {
    enum Tab {
        case leaderboard, awards
    }
}
struct ScoreboardResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardResultsView()
    }
}

