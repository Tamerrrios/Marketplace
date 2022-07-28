//
//  OrdersView.swift
//  TexnomartiOS
//
//  Created by yns on 17.05.2022.
//

import SwiftUI

struct OrdersView: View {
    var body: some View {
        CustomNavBar(navTitle: "Войти", callback: {}, content: {
            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: .displayWidth(90), height: 72)
                        .foregroundColor(.lightGray)

                    Text("Войдите в личный кабинет, чтобы \nпосмотреть свои заказы")
                        .tracking(0.25)
                        .multilineTextAlignment(.center)
                        .robotoRegular(fontSize: 14, fontColor: .blackGray.opacity(0.7))
                }
                .padding(.top, 16)

                VStack(alignment: .leading) {
                    Text("Номер телефона")
                        .tracking(0.4)
                        .robotoRegular(fontSize: 12, fontColor: .grayColor)
                        .padding(.top, 28)
                        .padding(.bottom, 6)

                    Text("+998 ")
                        .tracking(0.25)
                        .robotoRegular(fontSize: 14, fontColor: .blackGray)

                    Divider()
                        .padding(.bottom, 40)

                    XButton(title: "Войти", btnWithStroke: false, onTap: {})
                        .padding(.bottom)

                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Text("Регистрация")
                                .tracking(0.4)
                                .robotoRegular(fontSize: 12, fontColor: .blue)
                        }
                        Spacer()
                    }

                    Spacer()
                }
            }
            .padding(.horizontal, 16)
        }, leftImage: "", showSearchButton: false)
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
