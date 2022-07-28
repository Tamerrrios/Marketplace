//
//  CustomNavBar.swift
//  TexnomartiOS
//
//  Created by yns on 31.03.2022.
//

import SwiftUI

struct CustomNavBar<Content>: View where Content: View {
    @Environment(\.presentationMode) var presentationMode
    var navTitle: String
    var callback: () -> Void
    let content: () -> Content
    let leftImage: String
    let showSearchButton: Bool

    init(
        navTitle: String,
        callback: @escaping () -> Void = {},
        @ViewBuilder content: @escaping () -> Content,
        leftImage: String = "arrow.left",
        showSearchButton: Bool = true
    ) {
        self.navTitle = navTitle
        self.callback = callback
        self.content = content
        self.leftImage = leftImage
        self.showSearchButton = showSearchButton
    }

    var body: some View {
        VStack(spacing: 0.0) {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: leftImage)
                            .resizable()
                            .font(.subheadline)
                            .frame(width: 17, height: 16)
                            .foregroundColor(.black)
                    }
                    Spacer()

                    Text(navTitle)
                        .font(.system(size: 17, weight: .bold))
                        .tracking(-0.41)
                        .multilineTextAlignment(.center)
                    Spacer()
                    if showSearchButton {
                        Button {
                            callback()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable(resizingMode: .tile)
                                .font(.headline)
                                .frame(width: 16, height: 16)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, UIDevice.current.hasNotch ? 40 : 10)
                .frame(width: .displayWidth(100), height: .isScreen4inch() ? 66 : 88)
                .background(Color.yellow)
            }
            content()
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(navTitle: "Телевизоры и телекарты") {} content: {
            Text("Test")
        }
    }
}
