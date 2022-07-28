//
//  ProfileFirstFeatures.swift
//  TexnomartiOS
//
//  Created by yns on 08.06.2022.
//

import SwiftUI

struct ProfileFirstFeatures: Identifiable {
    var id = UUID()
    var title = ""
    var image = ""
    var showLang = false
}

extension ProfileFirstFeatures {
    static var mockData: [ProfileFirstFeatures] {
        [
            ProfileFirstFeatures(title: "Акции", image: "NounSale"),
            ProfileFirstFeatures(title: "Избранное", image: "nounFavorite"),
            ProfileFirstFeatures(title: "Сравнение", image: "scaleImage"),
            ProfileFirstFeatures(title: "Просмотренные", image: "nounShow"),
            ProfileFirstFeatures(title: "Выбор города", image: "nounPinLocation"),
            ProfileFirstFeatures(title: "Язык приложения", image: "nounEarth", showLang: true),
            ProfileFirstFeatures(title: "Наши магазины", image: "nounShopping"),
            ProfileFirstFeatures(title: "Информация", image: "informationImage"),
            ProfileFirstFeatures(title: "Служба поддержки", image: "FAQ"),
            ProfileFirstFeatures(title: "Чат со специалистом", image: "nounChat"),
            ProfileFirstFeatures(title: "О приложении", image: "nounSmartphone"),
        ]
    }
}
