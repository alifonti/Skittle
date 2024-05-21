//
//  AnimatingNumberView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/19/24.
//

import SwiftUI

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
