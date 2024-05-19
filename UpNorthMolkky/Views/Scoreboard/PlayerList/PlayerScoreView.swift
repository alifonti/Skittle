//
//  PlayerScoreView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/23/23.
//

import SwiftUI

struct PlayerScoreView: View {
    @AppStorage("PreferDetailedScoreView") var preferDetailedScoreView: Bool = false
    
    @State var isSimpleView: Bool = true
    
    @State var scoreAnimationCopy: Int = 0
    @State var scoreAnimationDifference: Int = 0
    
    init(round: MolkkyRound, playerScore: MolkkyRound.ContenderScore, currentPlayer: Bool) {
        self.round = round
        self.playerScore = playerScore
        self.currentPlayer = currentPlayer
        _isSimpleView = State(initialValue: !preferDetailedScoreView)
        _scoreAnimationCopy = State(initialValue: playerScore.totalScore)
        _scoreAnimationDifference = State(initialValue: 0)
    }
    
    let round: MolkkyRound
    var playerScore: MolkkyRound.ContenderScore
    var currentPlayer: Bool
    
    var accentColor: Color {
        if (currentPlayer) {
            if(playerScore.isInWarning) {
                return Color(UIColor.systemOrange)
            } else {
                return Color(UIColor.tintColor)
            }
        } else if (!playerScore.isFinished) {
            return Color(UIColor.label)
        } else if (playerScore.isEliminated) {
            return Color(UIColor.tertiaryLabel)
        } else if (playerScore.finishPosition == 0) {
            return Color(red: 0.99, green: 0.86, blue: 0.36)
        } else if (playerScore.finishPosition == 1) {
            return Color(red: 0.8, green: 0.8, blue: 0.8)
        } else if (playerScore.finishPosition == 2) {
            return Color(red: 0.9, green: 0.72, blue: 0.47)
        } else {
            return Color(UIColor.label)
        }
    }
    
    var numberOfAllowedMisses: Int {
        round.missesForElimination
    }
    var numberOfRecentMisses: Int {
        for (index, element) in playerScore.attempts.reversed().enumerated() {
            if (element.score != 0) {
                return index
            }
        }
        if (playerScore.attempts.count > 0 && playerScore.attempts[0].score == 0) {
            return playerScore.attempts.count
        } else {
            return 0
        }
    }
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(currentPlayer ? accentColor : .clear)
                .frame(width: 10)
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(playerScore.contender.name)
                        .font(isSimpleView ? .title : .title2)
                        .foregroundColor(Color(UIColor.label))
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(Array(playerScore.attempts.enumerated()), id: \.element.id) { index, item in
                                    ScoreboardView.getNumberAsText(value: item.score)
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .fixedSize()
                                        .background(index % 2 == 0 ? Color(UIColor.systemFill).opacity(1) : Color(UIColor.quaternarySystemFill).opacity(1))
                                        .id(item.id)
                                }
                            }
                        }
                        .onChange(of: playerScore.attempts.count) {
                            withAnimation {
                                proxy.scrollTo(playerScore.attempts.last?.id, anchor: .leading)
                            }
                        }
                    }
                    .modifier(PlayerScoreView.EmptyModifier(isEmpty: isSimpleView))
                }
                Spacer()
                HStack {
                    if (playerScore.finishPosition < 0) {
                        MissScoreView(round: round, playerScore: playerScore, isSimpleView: isSimpleView, displayAccentColor: accentColor)
                        Color.clear
                            .frame(width: 40, alignment: .trailing)
                            .modifier(AnimatableNumberModifier(number: scoreAnimationCopy))
                            .font(.title)
                            .foregroundColor(playerScore.isFinished ? accentColor : Color(UIColor.label))
                    } else {
                        MedalView(finishPosition: playerScore.finishPosition + 1, accentColor: accentColor)
                            .frame(width: 40, alignment: .center)
                    }
                }
            }
            .padding()
            .padding([.top, .bottom], -2)
        }
        .background(currentPlayer ? accentColor.opacity(0.05) : Color(UIColor.systemBackground))
        .onChange(of: playerScore.totalScore) {
            scoreAnimationDifference = abs(playerScore.totalScore - scoreAnimationCopy)
            scoreAnimationCopy = playerScore.totalScore
        }
        .animation(.linear(duration: 0.6 * (Double(scoreAnimationDifference) / 12.0)), value: scoreAnimationCopy)
        .onTapGesture {
            isSimpleView = !isSimpleView
        }
    }
}

extension PlayerScoreView {
    struct EmptyModifier: ViewModifier {
        let isEmpty: Bool
        func body(content: Content) -> some View {
            Group {
                if isEmpty {
                    EmptyView()
                } else {
                    content
                }
            }
        }
    }
}

//struct PlayerScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerScoreView()
//    }
//}
