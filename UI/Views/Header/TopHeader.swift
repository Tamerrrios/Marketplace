//
//  SearchView.swift
//  TexnomartiOS
//
//  Created by yns on 18.03.2022.
//

import SwiftUI

struct TopHeader: View {
    @Binding var searchText: String
    @Binding var isHideLogo: Bool
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top

    var body: some View {
        ZStack {
            VStack(spacing: 14.0) {
                if !isHideLogo {
                    Image("texnomartLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 18)
                }
                SearchBarView(searchText: $searchText).padding(.bottom, 14)
            }
            .padding(.top, top)
            .background(Color.colorYellow)
            .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
            .shadow(color: .shadowColor, radius: 5, x: 0, y: 5)
        }
        .ignoresSafeArea()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBarView()
            TopHeader(searchText: .constant(""), isHideLogo: .constant(true))
        }
    }
}
