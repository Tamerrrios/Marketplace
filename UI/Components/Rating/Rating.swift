//
//  Rating.swift
//  TexnomartiOS
//
//  Created by yns on 26.03.2022.
//

import SwiftUI

struct Rating: View {
    var rating: CGFloat
    var reviewsCount: String

    var body: some View {
        let stars = HStack(alignment: .center, spacing: 4) {
            ForEach(0 ..< 5) { _ in
                Image("starFill")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 8, height: 8)
            }
            Text(reviewsCount)
                .robotoRegular(fontSize: 10, fontColor: .grayText)
        }
        stars.overlay(
            GeometryReader { geo in
                let width = rating / CGFloat(6) * geo.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width, height: geo.size.height)
                        .foregroundColor(.colorYellow)
                }
            }
            .mask(stars)
        )
        .foregroundColor(.grayColor)
    }
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Rating(rating: 1.6, reviewsCount: "5")
    }
}
