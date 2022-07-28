//
//  CustomLoading.swift
//  TexnomartiOS
//
//  Created by yns on 15.04.2022.
//

import SwiftUI

struct CustomLoading: View {
    @State var isAnimating = false
    private var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }

    var body: some View {
        Image("loadingImage")
            .resizable()
            .frame(width: 40.0, height: 40.0)
            .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
            .onAppear {
                withAnimation(self.foreverAnimation) {
                    self.isAnimating = true
                }
            }
    }
}

struct CustomLoading_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoading()
    }
}
