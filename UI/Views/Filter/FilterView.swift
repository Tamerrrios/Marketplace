//
//  FilterView.swift
//  TexnomartiOS
//
//  Created by yns on 15.06.2022.
//

import SwiftUI

struct FilterView: View {
    @State private var filterCount: Int = 0

    var body: some View {
        CustomNavBar(navTitle: "Фильтр", callback: {}, content: {
            HStack {
                Text("Выбранно: \(filterCount.description)")
                    .tracking(0.1)
                    .robotoMedium(fontSize: 16, fontWeight: .medium)
                    .foregroundColor(.blackGray)
                Spacer()
                Button {} label: {
                    Text("Очистить")
                        .foregroundColor(Color.blue)
                        .tracking(0.1)
                        .robotoMedium(fontSize: 16, fontWeight: .medium)
                }
            }
            .padding([.top, .horizontal], 16)

            Spacer()
        }, leftImage: "xmark", showSearchButton: false)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
