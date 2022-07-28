//
//  ActionView.swift
//  TexnomartiOS
//
//  Created by yns on 30.06.2022.
//

import SwiftUI

struct ActionView: View {
    var body: some View {
        CustomNavBar(navTitle: "Акции", callback: {}, content: {
            ActionEmpty()
        }, showSearchButton: false).navigationBarHidden(true)
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView()
    }
}
