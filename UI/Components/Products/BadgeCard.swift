//
//  BadgeCard.swift
//  TexnomartiOS
//
//  Created by yns on 07.04.2022.
//

import SwiftUI

struct BadgeCard: View {
    var key: KeyResponse

    var body: some View {
        ZStack {
            switch key {
            case .vaucherSovg:
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.bozordanArzonClr)
                    .frame(width: 44, height: 16)
                badgeTitle(badgeTitle: "Ваучер")

            case .hitProducts:
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.hitProductsClr)
                    .frame(width: 66, height: 16)
                badgeTitle(badgeTitle: "Хит продаж")

            case .recommendedProducts:
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.recommendedClr)
                    .frame(width: 74, height: 16)
                badgeTitle(badgeTitle: "Рекомендуем")

            case .skidka:
                RoundedRectangle(cornerRadius: 4)
                    .fill(.yellow)
                    .frame(width: 44, height: 16)
                badgeTitle(badgeTitle: "Скидка")

            case .zornarh:
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.blackGray)
                    .frame(width: 72, height: 16)
                badgeTitle(badgeTitle: "Лучшая цена", textColor: .colorYellow)
            }
        }
    }
}

struct BadgeCard_Previews: PreviewProvider {
    static var previews: some View {
        BadgeCard(key: .vaucherSovg)
    }
}

extension BadgeCard {
    @ViewBuilder func badgeTitle(badgeTitle: String, textColor: Color = .white) -> some View {
        Text(badgeTitle)
            .foregroundColor(textColor)
            .tracking(0.4)
            .textCase(.lowercase)
            .robotoRegular(fontSize: 10, fontColor: .white)
    }
}
