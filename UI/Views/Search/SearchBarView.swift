//
//  SearchBarView.swift
//  TexnomartiOS
//
//  Created by yns on 30.03.2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.lightGray)

            HStack(spacing: 8.0) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(searchText.isEmpty ? .grayColor : .blackGray)
                    .frame(width: 24, height: 24)

                TextField("Хочу купить", text: $searchText)
                    .robotoRegular(fontSize: 14, fontColor: .blackGray)
                    .disableAutocorrection(true)
                    .overlay(
                        Image(systemName: "xmark")
                            .frame(width: 22, height: 22)
                            .padding(.trailing, 12.0)
                            .offset(x: -10)
                            .foregroundColor(.blackGray.opacity(0.7))
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                hideKeyboard()
                                searchText = ""
                            }, alignment: .trailing
                    )
            }
            .padding(.horizontal, 16)
            .foregroundColor(.gray)
            .overlay(
                HStack(alignment: .center, spacing: 8.0) {
                    if searchText.isEmpty {
                        Divider()
                            .frame(height: 20, alignment: .center)
                    }

                    Image("mic")
                        .frame(width: 12, height: 18)
                        .foregroundColor(.grayColor)
                }
                .padding(.horizontal, 16), alignment: .trailing
            )
        }
        .frame(height: 40)
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

struct MainSearch_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("iPhone"))
    }
}
