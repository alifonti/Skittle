//
//  SlidingSelection.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/19/24.
//

import SwiftUI

struct SlidingSelectionInput: View {
    @Binding var value: Bool
    var leftLabel: String = " "
    var rightLabel: String = " "
    
    let selectedColor: Color = Color(hue: 0.6, saturation: 0.6, brightness: 0.8)
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
                    .background(value ? selectedColor : unselectedColor)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 5, topTrailingRadius: 5, style: .continuous))
            })
        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 3.0)
//                .fixedSize()
//                .foregroundStyle(.white)
//                .padding(.all, 3)
//                .overlay(
//                    Image(systemName: value ? "checkmark" : "xmark")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .font(Font.title.weight(.black))
//                        .frame(width: 8, height: 8, alignment: .center)
//                        .foregroundStyle(value ? .black : .gray)
//                )
//                .offset(x: value ? 11 : -11, y: 0)
//                .animation(.linear, value: 0.1)
//        )
    }
}

struct SlidingSelectionInput_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(false) { SlidingSelectionInput(value: $0, leftLabel: "A", rightLabel: "B") }
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    var body: some View {
        content($value)
    }

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
