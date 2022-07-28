//
//  ProfileView.swift
//  TexnomartiOS
//
//  Created by yns on 16.05.2022.
//

import SwiftUI

struct ProfileView: View {
    @State private var firstProfileFeautures = ProfileFirstFeatures.mockData
    @State private var showLoginView: Bool = false
    @State private var showSignUpView: Bool = false

    var body: some View {
        NavigationView {
            CustomNavBar(navTitle: "Профиль", callback: {}, content: {
                ScrollView(showsIndicators: false) {
                    XButton(title: "Войти", btnWithStroke: false) {
                        showLoginView = true
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 16)
                    XButton(title: "Зарегистрироваться", btnWithStroke: true) {
                        showSignUpView = true
                    }
                    .padding(.bottom, 32)

                    NavigationLink(destination: ActionView()) {
                        ProfileListRow(profile: firstProfileFeautures[0])
                    }

                    NavigationLink(destination: FavouriteView()) {
                        ProfileListRow(profile: firstProfileFeautures[1])
                    }

                    ForEach(firstProfileFeautures[2 ..< firstProfileFeautures.endIndex]) { firstFeauture in
                        ProfileListRow(profile: firstFeauture)
                    }
                }
            }, leftImage: "", showSearchButton: false).navigationBarHidden(true)
                .background(NavigationLink(destination: LoginView().navigationBarHidden(true), isActive: $showLoginView, label: {
                    EmptyView()
                }))
                .background(NavigationLink(destination: SignUpView(), isActive: $showSignUpView, label: {
                    EmptyView()
                }))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
