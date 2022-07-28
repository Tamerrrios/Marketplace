//
//  SplashScreen.swift
//  TexnomartiOS
//
//  Created by yns on 12.05.2022.
//

import SwiftUI

struct SplashScreen: View {
    @State var isAnimating = false
    private var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }

    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.colorYellow)
            VStack {
                Image("texnomartLogo")
                    .resizable()
                    .frame(width: 201, height: 33)
            }
        }
        .overlay(
            VStack {
                Image("Ellipse")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
                    .onAppear {
                        withAnimation(self.foreverAnimation) {
                            self.isAnimating = true
                        }
                    }
            }, alignment: .bottom
        )
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
