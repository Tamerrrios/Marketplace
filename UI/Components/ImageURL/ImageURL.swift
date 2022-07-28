//
//  ImageURL.swift
//  TexnomartiOS
//
//  Created by yns on 23.03.2022.
//

import SDWebImageSwiftUI
import SwiftUI

struct ImageURL: View {
    var url: String = ""
    var fillerWidth: CGFloat = .displayWidth(90)
    var fillerHeight: CGFloat = .displayHeight(21.8)
    var fillerImage: String = "photo.on.rectangle"

    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .renderingMode(.original)
            .placeholder {
                ZStack {
                    Color.lightGray
                    Image(systemName: fillerImage)
                        .resizable()
                        .foregroundColor(.grayColor)
                        .frame(width: 70, height: 60)
                }
                .frame(width: fillerWidth, height: fillerHeight)
                .cornerRadius(11)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
    }
}
