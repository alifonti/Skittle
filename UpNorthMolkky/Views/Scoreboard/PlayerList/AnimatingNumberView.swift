//
//  AnimatingNumberView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/19/24.
//

import SwiftUI

struct AnimatingNumberView: View {

    // Change 1: number is now a Double
    @State private var number: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            // Change 2: we have a container with our modifier applied
            Color.clear
                .frame(width: 50, height: 50)
                .modifier(AnimatableNumberModifier(number: number))

            Button {
                withAnimation {
                    number = .random(in: 0 ..< 200)
                }
            } label: {
                Text("Create random number")
            }
        }
    }
}

struct AnimatingNumberView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingNumberView()
    }
}

struct AnimatableNumberModifier: AnimatableModifier {
    var animatableData: Double

    init(number: Int) {
        animatableData = Double(number)
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                Text("\(Int(animatableData))")
            )
    }
}
