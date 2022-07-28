//
//  ListRowContent.swift
//  TexnomartiOS
//
//  Created by yns on 15.06.2022.
//

import SwiftUI

struct ListRowContent: View {
    @State var list: ListCategoriesDataResponse = .init()

    var body: some View {
        HStack {
            Text(list.title)
                .tracking(0.1)
                .robotoMedium(fontSize: 14, fontWeight: .medium)
                .foregroundColor(.grayColor)
            Spacer()
            if list.hasSubCategory {
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 7, height: 12)
                    .foregroundColor(.gray)
                    .font(.body)
            }
        }
    }
}

struct RistRowContent_Previews: PreviewProvider {
    static var previews: some View {
        ListRowContent()
    }
}
