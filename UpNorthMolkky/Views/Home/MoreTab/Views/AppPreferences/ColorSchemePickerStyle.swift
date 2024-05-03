//
//  ColorSchemePickerStyle.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 5/3/24.
//

import SwiftUI

struct ColorSchemePicker: View {
    @AppStorage("PreferredColorScheme", store: .standard) var preferredColorSchemePreference: String = "auto"
    
    var body: some View {
        HStack {
            Button("Auto") {
                UserDefaults.standard.set("auto", forKey: "PreferredColorScheme")
            }
            .buttonStyle(AutoColorSchemeButton(selected:  preferredColorSchemePreference == "auto"))
            Button("Light") {
                UserDefaults.standard.set("light", forKey: "PreferredColorScheme")
            }
            .buttonStyle(LightModeButton(selected: preferredColorSchemePreference == "light"))
            Button("Dark") {
                UserDefaults.standard.set("dark", forKey: "PreferredColorScheme")
            }
            .buttonStyle(DarkModeButton(selected: preferredColorSchemePreference == "dark"))
        }
        .padding(.all, 10)
        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
            return 0
        }
    }
}

struct LightModeButton: ButtonStyle {
    let selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(UIColor.systemTeal))
                Image(systemName: "textformat.abc")
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 5))
            }
            .environment(\.colorScheme, .light)
            configuration.label
            ColorSchemeCheckmarkButton(selected: selected)
        }
        .foregroundStyle(Color(UIColor.label))
    }
}

struct DarkModeButton: ButtonStyle {
    let selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(UIColor.systemTeal))
                RoundedRectangle(cornerRadius: 5)
                    .fill(.thinMaterial)
                    .padding(.all, 0)
                Image(systemName: "textformat.abc")
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 5))
            }
            .environment(\.colorScheme, .dark)
            configuration.label
            ColorSchemeCheckmarkButton(selected: selected)
        }
        .foregroundStyle(Color(UIColor.label))
    }
}

struct AutoColorSchemeButton: ButtonStyle {
    let selected: Bool
    
    let topHalf = UnevenRoundedRectangle(topLeadingRadius: 5, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 5)
    let bottomHalf = UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 5, bottomTrailingRadius: 5, topTrailingRadius: 0)
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            VStack(spacing: 0) {
                ZStack {
                    topHalf
                        .fill(Color(UIColor.systemTeal))
                    Image(systemName: "textformat.abc")
                        .padding()
                        .background(.regularMaterial, in: topHalf)
                        .offset(x: 0, y: 4)
                }
                .environment(\.colorScheme, .light)
                ZStack {
                    bottomHalf
                        .fill(Color(UIColor.systemTeal))
                    bottomHalf
                        .fill(.thinMaterial)
                        .padding(.all, 0)
                    Image(systemName: "textformat.abc")
                        .padding()
                        .background(.regularMaterial, in: bottomHalf)
                        .offset(x: 0, y: -4)
                }
                .environment(\.colorScheme, .dark)
            }
            configuration.label
            ColorSchemeCheckmarkButton(selected: selected)
        }
        .foregroundStyle(Color(UIColor.label))
    }
}

struct ColorSchemeCheckmarkButton: View {
    let selected: Bool
    
    var body: some View {
        if (selected) {
            Circle()
                .fill(Color(UIColor.tintColor))
                .overlay {
                    Image(systemName: "checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(Font.title.weight(.semibold))
                        .frame(width: 10, height: 10, alignment: .center)
                        .foregroundStyle(Color(UIColor.systemBackground))
                }
                .frame(width: 20, height: 20)
        } else {
            Circle()
                .fill(Color(UIColor.systemBackground))
                .stroke(Color(UIColor.secondaryLabel))
                .frame(width: 20, height: 20)
        }
    }
}
