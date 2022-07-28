//
//  BasketView.swift
//  TexnomartiOS
//
//  Created by yns on 17.05.2022.
//

import SwiftUI

struct BasketView: View {
    var body: some View {
        CustomNavBar(navTitle: "Корзина", callback: {}, content: {
            VStack {
                Spacer()
                Image("shoppingCart")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .padding(.bottom, 16)

                Text("В корзине пока \nничего нет")
                    .tracking(0.1)
                    .multilineTextAlignment(.center)
                    .robotoMedium(fontSize: 18, fontWeight: .medium)

                XButton(title: "Перейти к покупкам", btnWithStroke: false) {}
                    .padding(.top, 24)
                Spacer()
            }
        }, leftImage: "", showSearchButton: false)
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
