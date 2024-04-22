//
//  HomeHeader.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 4/21/24.
//

import SwiftUI

struct HomeHeaderView: View {
    @Binding var selectedTab: String
    
    @State private var headerText: String = "play"
    @State private var headerColor: Color = Color(hue: 0.6, saturation: 0.6, brightness: 0.8)
    @State private var headerBackgroundColor: Gradient = Gradient(
        colors: [Color(hue: 0.6, saturation: 0.6, brightness: 0.8, opacity: 0.25), Color(hue: 0.6, saturation: 0.6, brightness: 0.8, opacity: 0)])
    @State private var nextHeaderBackgroundColor: Gradient = Gradient(
        colors: [Color(hue: 0.6, saturation: 0.6, brightness: 0.8, opacity: 0.25), Color(hue: 0.6, saturation: 0.6, brightness: 0.8, opacity: 0)])
    
    @State private var animationProgress: CGFloat = 0
    
    var body: some View {
        VStack() {
            HStack(alignment: .center, spacing: 1) {
                Text("Skittle")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(headerText)
                    .id(headerText)
                    .foregroundStyle(headerColor)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .move(edge: .top).combined(with: .opacity)
                    ))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Rectangle()
            .modifier(AnimatableGradientModifier(fromGradient: headerBackgroundColor, toGradient: nextHeaderBackgroundColor, progress: animationProgress))
            .ignoresSafeArea()
        )
        .onChange(of: selectedTab) {
            withAnimation(Animation.linear(duration: 0.25)) {
                let newColor = HomeHeaderView.getHeaderColor(tab: selectedTab)
                self.headerText = selectedTab
                self.headerColor = newColor
                self.nextHeaderBackgroundColor = Gradient(colors: [newColor.opacity(0.25), newColor.opacity(0)])
                self.animationProgress = 1.0
            } completion: {
                headerBackgroundColor = nextHeaderBackgroundColor
                self.animationProgress = 0
            }
        }
    }
}

extension HomeHeaderView {
    static func getHeaderColor(tab: String) -> Color {
        if (tab == "play") {
            return Color(hue: 0.6, saturation: 0.6, brightness: 0.8)
        } else if (tab == "history") {
            return Color(hue: 0.8, saturation: 0.6, brightness: 0.8)
        } else if (tab == "more") {
            return Color(hue: 0.0, saturation: 0.6, brightness: 0.8)
        } else {
            return Color(hue: 0.6, saturation: 0.6, brightness: 0.8)
        }
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(selectedTab: .constant("play"))
    }
}

struct AnimatableGradientModifier: AnimatableModifier {
    let fromGradient: Gradient
    let toGradient: Gradient
    var progress: CGFloat = 0.0
 
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
 
    func body(content: Content) -> some View {
        var gradientColors = [Color]()
 
        for i in 0..<fromGradient.stops.count {
            let fromColor = UIColor(fromGradient.stops[i].color)
            let toColor = UIColor(toGradient.stops[i].color)
 
            gradientColors.append(colorMixer(fromColor: fromColor, toColor: toColor, progress: progress))
        }
 
        return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
    }
 
    func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
        guard let fromColor = fromColor.cgColor.components else { return Color(fromColor) }
        guard let toColor = toColor.cgColor.components else { return Color(toColor) }
 
        let red = fromColor[0] + (toColor[0] - fromColor[0]) * progress
        let green = fromColor[1] + (toColor[1] - fromColor[1]) * progress
        let blue = fromColor[2] + (toColor[2] - fromColor[2]) * progress
        let opacity = fromColor[3] + (toColor[3] - fromColor[3]) * progress
 
        return Color(red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(opacity))
    }
}
