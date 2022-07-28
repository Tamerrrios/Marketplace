//
//  CardScroll.swift
//  TexnomartiOS
//
//  Created by yns on 21.03.2022.
//

import SwiftUI

struct Header<Content>: View where Content: View {
    var title: String
    var callback: () -> Void
    let content: () -> Content

    init(
        title: String,
        callback: @escaping () -> Void = {},
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.callback = callback
        self.content = content
    }

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .tracking(0.1)
                    .robotoMedium(fontSize: 18, fontWeight: .medium)

                Spacer()

                Button {
                    callback()
                } label: {
                    HStack(spacing: 4.0) {
                        Text("все")
                            .tracking(0.4)
                            .robotoRegular(fontSize: 12, fontColor: .grayColor)
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 7, height: 12)
                            .foregroundColor(.grayColor)
                            .font(.body)
                    }
                }
            }
            .padding(.horizontal, 16)
            content()
                .padding(.top, 8)
        }
    }
}

struct CardScroll_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Категории") {
            Text("Test")
        }
    }
}
