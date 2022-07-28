//
//  FavouriteView.swift
//  TexnomartiOS
//
//  Created by yns on 30.06.2022.
//

import SwiftUI

struct FavouriteView: View {
    var body: some View {
        CustomNavBar(navTitle: "Избранное", callback: {}, content: {
            Spacer()
            Text("Избранное")
                .robotoMedium(fontSize: 20, fontWeight: .medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.blackGray)
            Spacer()
        }, showSearchButton: false).navigationBarHidden(true)
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
