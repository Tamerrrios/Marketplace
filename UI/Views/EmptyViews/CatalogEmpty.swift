//
//  CatalogEmpty.swift
//  TexnomartiOS
//
//  Created by yns on 30.06.2022.
//

import SwiftUI

struct CatalogEmpty: View {
    var body: some View {
        VStack {
            Spacer()
            Image("catalogEmpty")
                .resizable()
                .frame(width: 64, height: 64)
            Text("К сожалению, в данной \nкатегории нет товаров")
                .robotoMedium(fontSize: 20, fontWeight: .medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.blackGray)
            Spacer()
        }
    }
}

struct CatalogEmpty_Previews: PreviewProvider {
    static var previews: some View {
        CatalogEmpty()
    }
}
