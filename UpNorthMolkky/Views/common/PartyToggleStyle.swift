//
//  PartyToggleStyle.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/11/24.
//

import SwiftUI

struct PartyToggleStyle: ToggleStyle {
    
    var funListColor: Color = Color(named: "s.accent3.main").opacity(0.5)
    var offColor: Color = Color(named: "s.fill.secondary")
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Rectangle()
                .foregroundStyle(configuration.isOn ? funListColor : offColor)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundStyle(.white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? "balloon.2.fill" : "balloon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.heavy))
                                .frame(width: 16, height: 16, alignment: .center)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(configuration.isOn ? Color(named: "s.accent1.main") : .gray, Color(named: "s.accent2.main"))
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

struct PartyToggleInput_Previews: PreviewProvider {
    static var previews: some View {
        Toggle(isOn: .constant(true), label: {
            Text("Active")
        })
        .toggleStyle(PartyToggleStyle())
    }
}
