//
//  BarToggleInput.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/11/24.
//

import SwiftUI

struct BarToggleInput: View {
    @Binding var value: Bool
    var leftLabel: String = " "
    var rightLabel: String = " "
    
    let selectedColor: Color = Color(hue: 0.13, saturation: 0.5, brightness: 0.95)
    let selectedShuffleColor: Color = Color(hue: 0.6, saturation: 0.25, brightness: 0.95)
    let unselectedColor: Color = Color(UIColor.secondarySystemFill)
    
    func updateValue(newValue: Bool) {
        value = newValue
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                updateValue(newValue: false)
            }, label: {
                Text(leftLabel)
                    .foregroundStyle(Color(UIColor.label))
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(!value ? selectedColor : unselectedColor)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 5, bottomLeadingRadius: 5, bottomTrailingRadius: 0, topTrailingRadius: 0, style: .continuous))
            })
            Button(action: {
                updateValue(newValue: true)
            }, label: {
                Text(rightLabel)
                    .foregroundStyle(Color(UIColor.label))
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(value ? selectedShuffleColor : unselectedColor)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 5, topTrailingRadius: 5, style: .continuous))
            })
        }
    }
}

struct BarToggleInput_Previews: PreviewProvider {
    static var previews: some View {
        BarToggleInput(value: .constant(true), leftLabel: "A", rightLabel: "B")
    }
}
