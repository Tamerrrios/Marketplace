//
//  LoginView.swift
//  TexnomartiOS
//
//  Created by yns on 02.07.2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var verifictionView = false

    var body: some View {
        NavigationView {
            CustomNavBar(navTitle: "Войти", callback: {}, content: {
                if viewModel.loadState == .loading {
                    Spacer()
                    CustomLoading()
                    Spacer()
                } else {
                    VStack {
                        Text("Добро пожаловать")
                            .tracking(0.1)
                            .robotoMedium(fontSize: 18, fontWeight: .medium)

                        PhoneTextField("Номер телефона",
                                       phoneNumber: $viewModel.phoneNumber,
                                       "+998", alertText: viewModel.phoneMessage) {
                            viewModel.phoneNumberValidation()
                        }

                        XButton(title: "Войти", onTap: {
                            viewModel.sendGetOtpCodeRequest {
                                verifictionView = true
                            }
                        })
                        .padding(.top, 40)

                        Button(action: {}) {
                            Text("Регистрация")
                                .tracking(0.4)
                                .robotoRegular(fontSize: 12, fontColor: .blue)
                        }
                        .padding(.top, 20)

                        Spacer()
                    }
                    .padding(.top, 60)
                    .padding(.horizontal, 16)
                }
            }, showSearchButton: false)
                .navigationBarHidden(true)
                .background(
                    NavigationLink(destination: VerificationView(viewModel: viewModel), isActive: $verifictionView, label: {
                        EmptyView()
                    })
                )
                .alert(isPresented: $viewModel.showPopup) {
                    Alert(title: Text("Ошибка"), message: Text(viewModel.errorMessage), dismissButton: .cancel(Text("OK")))
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
