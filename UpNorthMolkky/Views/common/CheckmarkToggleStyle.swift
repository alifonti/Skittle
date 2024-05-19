//
//  SliderToggleInput.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/11/24.
//

import SwiftUI

struct CheckmarkToggleStyle: ToggleStyle {
    
    let enabledColor: Color = Color(named: "s.accent2.main")
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundStyle(configuration.isOn ? enabledColor : .gray)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundStyle(.white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? "checkmark" : "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.black))
                                .frame(width: 8, height: 8, alignment: .center)
                                .foregroundStyle(configuration.isOn ? .black : .gray)
                        )
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(.linear, value: 0.1)
                )
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct CheckmarkToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle(isOn: .constant(true), label: {
            Text("Active")
        })
        .toggleStyle(CheckmarkToggleStyle())
    }
}
