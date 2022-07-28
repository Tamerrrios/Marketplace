//
//  TabBarView.swift
//  TexnomartiOS
//
//  Created by yns on 17.03.2022.
//

import SwiftUI

struct TabBarView: View {
    @State private var currentTab = Tab.main

    var body: some View {
        TabView(selection: $currentTab) {
            MainView(catalogTab: $currentTab)
                .tag(Tab.main)

            CatalogView()
                .tag(Tab.catalog)

            BasketView()
                .tag(Tab.basket)

            OrdersView()
                .tag(Tab.orders)

            ProfileView()
                .tag(Tab.profile)
        }
        .overlay(
            HStack(spacing: 0.0) {
                tabButton(tab: .main)
                tabButton(tab: .catalog)
                tabButton(tab: .basket)
                tabButton(tab: .orders)
                tabButton(tab: .profile)
            }
            .padding(.top, 8)
            .background(
                Color.tabBarColor
                    .clipShape(RoundedRectangle(cornerRadius: 0))
                    .ignoresSafeArea(.container, edges: .bottom)
            ), alignment: .bottom
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

extension TabBarView {
    @ViewBuilder
    func tabButton(tab: Tab) -> some View {
        Button {
            withAnimation(.easeOut(duration: 0.2)) {
                currentTab = tab
            }
        } label: {
            VStack {
                Image(tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(currentTab == tab ? .blackGray : .grayColor)
                    .frame(maxWidth: .infinity)
                    .scaleEffect(currentTab == tab ? 1.3 : 1)

                Text(tab.rawValue)
                    .robotoRegular(fontSize: 11, fontColor: currentTab == tab ? .blackGray : .grayColor)
            }
        }
    }
}
