//
//  ShimmerBox.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/24/23.
//

import SwiftUI

struct ShimmerBox : View {
    @State var show = false
    
    var body: some View {
        GeometryReader { geometry in
            HStack {}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white.opacity(0.75))
//                .background(.red)
                .mask(
                    Capsule()
                        .fill(LinearGradient(gradient: .init(colors: [.clear, .white, .clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 55.0))
                        .scaleEffect(x: 1.2, y: 1.0, anchor: .leading)
                        .offset(x: self.show ? 1.5 * geometry.size.width : -1.5 * geometry.size.width)
                )
                .blur(radius: 5)
                .onAppear {
                    withAnimation(Animation.default.speed(0.08).delay(0).repeatForever(autoreverses: false)) {
                        self.show.toggle()
                    }
                }
        }
    }
}
