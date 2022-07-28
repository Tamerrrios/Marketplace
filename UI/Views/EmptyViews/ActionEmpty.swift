//
//  ActionEmpty.swift
//  TexnomartiOS
//
//  Created by yns on 30.06.2022.
//

import SwiftUI

struct ActionEmpty: View {
    var body: some View {
        VStack {
            Spacer()
            Image("actionEmpty")
                .resizable()
                .frame(width: 52, height: 52)
            Text("Акции скоро будут!")
                .robotoMedium(fontSize: 20, fontWeight: .medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.blackGray)
            Spacer()
        }
    }
}

struct ActionEmpty_Previews: PreviewProvider {
    static var previews: some View {
        ActionEmpty()
    }
}
