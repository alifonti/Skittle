//
//  FormationView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/19/24.
//

import SwiftUI
import CoreGraphics


struct FormationCircleView: View {
    let number: Int
    
    var body: some View {
        Image(systemName: "\(number).circle")
            .font(.largeTitle)
    }
}

struct FormationView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                FormationCircleView(number: 7)
                FormationCircleView(number: 9)
                FormationCircleView(number: 8)
            }
            HStack(spacing: 0) {
                FormationCircleView(number: 5)
                FormationCircleView(number: 11)
                FormationCircleView(number: 12)
                FormationCircleView(number: 6)
            }
            HStack(spacing: 0) {
                FormationCircleView(number: 3)
                FormationCircleView(number: 10)
                FormationCircleView(number: 4)
            }
            HStack(spacing: 0) {
                FormationCircleView(number: 1)
                FormationCircleView(number: 2)
            }
        }
    }
}

#Preview {
    FormationView()
}
