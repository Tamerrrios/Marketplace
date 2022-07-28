//
//  SignUpView.swift
//  TexnomartiOS
//
//  Created by yns on 02.07.2022.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        CustomNavBar(navTitle: "Регистрация", callback: {}, content: {
            VStack {
                Text("Добро пожаловать")
                    .tracking(0.1)
                    .robotoMedium(fontSize: 18, fontWeight: .medium)
                Spacer()
            }
        }, showSearchButton: false).navigationBarHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
