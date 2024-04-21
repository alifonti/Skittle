//
//  NumberInput.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/11/24.
//

import SwiftUI

struct NumberInput: View {
    @Binding var value: Int
    var increment: Int = 1
    var minimumValue: Int = Int.min
    var maximumValue: Int = Int.max
    
    let buttonColor: Color = Color(hue: 0.6, saturation: 0.85, brightness: 0.55)
    
    func changeValue(number: Int) {
        value += increment * number
    }
    
    var body: some View {
        HStack {
            Image(systemName: "minus.circle.fill")
                .font(.title2)
                .foregroundStyle(buttonColor)
                .opacity(value <= minimumValue ? 0 : 1)
                .onTapGesture {
                    if (value - increment >= minimumValue) {
                        changeValue(number: -1)
                    }
                }
            Text(String(value))
                .font(.title)
//                .padding([.horizontal])
//                .background(
//                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
//                        .fill(Color(UIColor.systemFill)
//                    )
//                )
            Image(systemName: "plus.circle.fill")
                .font(.title2)
                .foregroundStyle(buttonColor)
                .opacity(value >= maximumValue ? 0 : 1)
                .onTapGesture {
                    if (value + increment <= maximumValue) {
                        changeValue(number: 1)
                    }
                }
        }
    }
}

struct NumberInput_Previews: PreviewProvider {
    static var previews: some View {
        NumberInput(value: .constant(0))
    }
}
