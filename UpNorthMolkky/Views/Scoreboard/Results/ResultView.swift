//
//  ResultView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/4/24.
//

import SwiftUI
import ConfettiSwiftUI

struct ScoreboardResultsView: View {
    @EnvironmentObject var store: MolkkyStore
    @EnvironmentObject var navigationState: NavigationState
    
    @Binding var round: MolkkyRound
    @Binding var isPresenting: Bool
    
    @State private var confettiAnimationCounter = 0
    
    @State var selectedTab: ScoreboardResultsView.Tab = ScoreboardResultsView.Tab.leaderboard
    
    let tabShape = UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 20)
    
    var winner: MolkkyRound.ContenderScore {
        round.contenderScores[round.contenderScores.firstIndex(where: {$0.finishPosition == 0}) ?? 0]
    }
    
    func onNewGameClick() {
        let newRound: MolkkyRound = MolkkyRound(round: round)
        store.userData.addRound(newRound)
        navigationState.activeRoundId = newRound.id
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Group {
                VStack(spacing: 0) {
                    VStack {
                        HStack {
                            Button(action: {navigationState.isNavigationActive = false}) {
                                Label("Home", systemImage: "chevron.backward")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        Spacer()
                        Text("\(winner.contender.name) wins!")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Spacer()
                        HStack {
                            Button(action: onNewGameClick) {
                                Label("Play again", systemImage: "play")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(named: "s.accent2.main")))
                            }
                            if (round.endedEarly || (!round.continueUntilAllFinished && round.contenders.count > 2)) {
                                Button(action: {
                                    if round.endedEarly {
                                        round.endedEarly.toggle()
                                    } else {
                                        round.continueUntilAllFinished.toggle()
                                    }
                                }) {
                                    Label("Continue playing", systemImage: "chevron.forward")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(named: "s.accent2.main")))
                                }
                            }
                        }
                        if (!round.endedEarly) {
                            Button(action: {
                                isPresenting.toggle()
                                round.undo()
                            }) {
                                Label("Undo last throw", systemImage: "arrow.uturn.backward")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 1))
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack(spacing: 10) {
                        ZStack {
                            HStack(spacing: 0) {
                                ScoreboardResultsTabView(selectedTab: $selectedTab, tabId: ScoreboardResultsView.Tab.leaderboard)
                                ScoreboardResultsTabView(selectedTab: $selectedTab, tabId: ScoreboardResultsView.Tab.awards)
                            }
                            .clipShape(Rectangle())
                        }
                        .background(tabShape.fill(Color(named: "s.accent1.main")))
                        TabView(selection: $selectedTab) {
                            ResultsLeaderboardView(round: round)
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all, edges: .bottom)
            .background(Color(named: "s.accent1.main"))
            EmptyView()
                .confettiCannon(counter: $confettiAnimationCounter, num: 50, rainHeight: 1500, radius: 600)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        confettiAnimationCounter += 1
                    }
                }
        }
    }
}


struct ScoreboardResultsTabView: View {
    @Binding var selectedTab: ScoreboardResultsView.Tab
    let tabId: ScoreboardResultsView.Tab
    
    let tabShape = UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 20)
    
    var isSelected: Bool {
        selectedTab == tabId
    }
    
    var body: some View {
        Button(action: {withAnimation{selectedTab = tabId}}) {
            Text(tabId.rawValue.capitalized)
                .font(.title3)
                .foregroundStyle(isSelected ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
        }
        .background(tabShape.fill(isSelected ? Color(UIColor.systemBackground) : Color(UIColor.systemGroupedBackground)))
        .clipShape(tabShape)
        .shadow(radius: isSelected ? 4 : 0, x: 0, y: 0)
        .zIndex(isSelected ? 1 : 0)
    }
}

extension ScoreboardResultsView {
    enum Tab: String, CaseIterable, Identifiable {
        case leaderboard, awards
        var id: Self { self }
    }
}
struct ScoreboardResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardResultsView(round: .constant(MolkkyRound.sampleData), isPresenting: .constant(true))
    }
}

