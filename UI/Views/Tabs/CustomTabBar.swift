//
//  CustomTabBar.swift
//  TexnomartiOS
//
//  Created by yns on 02.07.2022.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var currentTab: Tab

    var body: some View {
        GeometryReader { _ in

            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Button {
                        withAnimation(.easeOut(duration: 0.2)) {
                            currentTab = tab
                        }
                    } label: {
                        VStack {
                            Image(tab.rawValue)
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(currentTab == tab ? .black : .gray)
                                .scaleEffect(currentTab == tab ? 1.3 : 1)

                            Text(tab.rawValue)
                                .robotoRegular(fontSize: 11, fontColor: currentTab == tab ? .blackGray : .grayColor)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 30)
        .padding(.bottom, 10)
        .padding([.horizontal, .top])
        .background(
            Color.tabBarColor
                .ignoresSafeArea()
        )
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(currentTab: .constant(.main))
    }
}
