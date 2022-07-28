//
//  LazyView.swift
//  TexnomartiOS
//
//  Created by yns on 06.04.2022.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}

struct LazyViewView_Previews: PreviewProvider {
    static var previews: some View {
        LazyView(Text("NavigationLazyView"))
    }
}
