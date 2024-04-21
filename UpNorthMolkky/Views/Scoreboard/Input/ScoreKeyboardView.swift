//
//  ContentView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/12/23.
//

import SwiftUI

struct ScoreKeyboardView: View {
    @Binding var round: MolkkyRound
    
    var onSubmitScore: (Int) -> Void
    
    var canRedo: Bool {
        round.undoStack.count > 0
    }
    
    @ViewBuilder
    func KeyboardButtonBuilder(value: Int) -> some View {
        KeyboardButton(disabled: round.hasGameEnded, onAction: {onSubmitScore(value)}, content: {
            Text(String(value))
        })
    }
    
    var body: some View {
        Grid {
            GridRow {
                KeyboardButtonBuilder(value: 1)
                KeyboardButtonBuilder(value: 2)
                KeyboardButtonBuilder(value: 3)
                KeyboardButtonBuilder(value: 4)
            }
            GridRow {
                KeyboardButtonBuilder(value: 5)
                KeyboardButtonBuilder(value: 6)
                KeyboardButtonBuilder(value: 7)
                KeyboardButtonBuilder(value: 8)
            }
            GridRow {
                KeyboardButtonBuilder(value: 9)
                KeyboardButtonBuilder(value: 10)
                KeyboardButtonBuilder(value: 11)
                KeyboardButtonBuilder(value: 12)
            }
            GridRow {
                KeyboardButton(disabled: round.attempts.count == 0, isPrimary: false, onAction: {round.undo()}, content: {
                    Image(systemName: "arrow.uturn.backward")
                })
                if (canRedo) {
                    KeyboardButton(disabled: false, isPrimary: false, onAction: {round.redo()}, content: {
                        Image(systemName: "arrow.uturn.forward")
                    })
                }
                KeyboardButtonBuilder(value: 0)
                    .gridCellColumns(canRedo ? 2 : 3)
            }
        }
    }
}

struct KeyboardButton<Content: View>: View {
    var disabled: Bool
    var isPrimary: Bool = true
    var onAction: () -> Void
    @ViewBuilder var content: Content
    
    var foregroundColor: Color {
        Color(UIColor.label)
        // disabled ? Color(UIColor.secondaryLabel) : Color(UIColor.label)
    }
    var backgroundColor: Color {
        isPrimary ? Color(named: "s.fill.primary") : Color(named: "s.fill.tertiary")
    }
    
    var body: some View {
        Button(action: {onAction()}) {
            content
                .frame(maxWidth: .infinity)
                .padding()
        }
        .foregroundColor(foregroundColor)
        .background(backgroundColor)
        .disabled(disabled)
        .clipShape(Capsule(style: .circular))
        .shadow(radius: 1, x: 0, y: 1)
    }
}

struct ScoreKeyboardView_Previews: PreviewProvider {
    static var handler: (Int) -> Void = {_ in}
    
    static var previews: some View {
        ScoreKeyboardView(round: .constant(MolkkyRound.sampleData), onSubmitScore: handler)
    }
}
