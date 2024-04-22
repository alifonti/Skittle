//
//  ContentView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/12/23.
//

import SwiftUI

struct ScoreHistoryView: View {
    @Binding var round: MolkkyRound
    
    @State var animationOffset: Int = 0
    
    var body: some View {
        HStack {
            if (round.attempts.count == 0) {
                EmptyHistoryElement()
                    .offset(x: 8 + CGFloat(animationOffset), y: 0)
                    .hidden()
            } else if (round.attempts.count == 1) {
                PastElement(attempt: $round.attempts[round.attempts.count - 1], history: $round.attempts)
                    .offset(x: 8 + CGFloat(animationOffset), y: 0)
                    .overlay(
                        EmptyHistoryElement()
                            .offset(x: -118 + CGFloat(animationOffset), y: 0)
                            .opacity(0)
                    )
            } else {
                PastElement(attempt: $round.attempts[round.attempts.count - 1], history: $round.attempts)
                    .offset(x: 8 + CGFloat(animationOffset), y: 0)
                    .overlay(
                        PastElement(attempt: $round.attempts[round.attempts.count - 2], history: $round.attempts)
                            .offset(x: -118 + CGFloat(animationOffset), y: 0)
                    )
            }
            HistoryElement(player: round.currentContender, playerScore: round.currentContenderScore, isCurrentPlayer: true, targetScore: round.targetScore)
                .offset(x: 0 + CGFloat(animationOffset), y: 0)
            HistoryElement(player: round.findNextContender(), playerScore: round.contenderScores.first(where: {$0.contender == round.findNextContender()}), isCurrentPlayer: false, targetScore: round.targetScore)
                .offset(x: -8 + CGFloat(animationOffset), y: 0)
                .overlay(
                    HistoryElement(player: round.findNextContender(1), playerScore: round.contenderScores.first(where: {$0.contender == round.findNextContender(1)}), isCurrentPlayer: false, targetScore: round.targetScore)
                        .offset(x: 118 + CGFloat(animationOffset), y: 0)
                )
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(radius: 2, x: 0, y: 2)
        .onChange(of: round.attempts) {
            animationOffset = round.wasAttemptAdded ? 118 : -118
            withAnimation() {
                animationOffset = 0
            } completion: {
                // animationOffset = 0
            }
        }
    }
}

struct EmptyHistoryElement: View {
    var body: some View {
        VStack {
            Text("A")
            Text("0")
        }
        .opacity(0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 2)
        .background(Color(named: "s.fill.tertiary"))
        .clipShape(BeveledRectangle())
    }
}

struct PastElement: View {
    @Binding var attempt: MolkkyRound.ContenderAttempt
    @Binding var history: [MolkkyRound.ContenderAttempt]
    
    var body: some View {
        VStack {
            Text(attempt.contender.name)
            Text(String(attempt.score))
        }
        .fontWeight(.light)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 2)
        .background(Color(named: "s.fill.tertiary"))
        .clipShape(BeveledRectangle())
    }
}

struct HistoryElement: View {
    var player: Contender?
    var playerScore: MolkkyRound.ContenderScore?
    var isCurrentPlayer: Bool
    var targetScore: Int
    
    var displayColor: Color {
        if (isCurrentPlayer) {
            return Color(named: "s.fill.primary")
            // return { if let playerScore { return playerScore.isInWarning }; return false }()
        } else {
            return Color(named: "s.fill.tertiary")
        }
    }
    
    var body: some View {
        var amountToWin: String {
            if ((targetScore - (playerScore?.totalScore ?? 0)) <= 12) {
                return "\(targetScore - (playerScore?.totalScore ?? 0))"
            } else {
                return ""
            }
        }
        
        VStack {
            Text(player?.name ?? "")
                .fontWeight(isCurrentPlayer ? .medium : .light)
            if (amountToWin != "" && isCurrentPlayer) {
                Text("\(amountToWin) to win")
                    .font(.subheadline)
            }
        }
        .foregroundColor(Color(UIColor.label))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 2)
        .background(displayColor)
        .clipShape(BeveledRectangle())
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        return path
    }
}

struct BeveledRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX - 5, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 5, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + 5, y: rect.midY))
        
        path.closeSubpath()

        return path
    }
}

struct ScoreHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreHistoryView(round: .constant(MolkkyRound.sampleData))
    }
}
