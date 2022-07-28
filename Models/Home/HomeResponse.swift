//
//  HomeResponse.swift
//  TexnomartiOS
//
//  Created by yns on 23.03.2022.
//

import Foundation
import SwiftUI

// MARK: - HomeResponse

struct HomeResponse: Codable {
    var success: Bool = false
    var errorCode: Int = 0
    var message: String = ""
    var data: DataResponse
}

// MARK: - DataClass

struct DataResponse: Codable {
    var slider: [SliderResponse] = []
    var categories: [CategoryResponse] = []
    var newProducts: [HitProductResponse] = []
    var hitProducts: [HitProductResponse] = []
    var recommendedProducts: [HitProductResponse] = []
    var specialCategoryProducts: [SpecialCategoryProductResponse] = []
}

// MARK: - Slider

struct SliderResponse: Codable, Identifiable {
    var id: Int = 0
    var title: String = ""
    var image: String = ""
    var slideDescription: String = ""
    var mobileLinkType: String = ""
    var mobileLinkCategoryID: Int?
    var mobileLinkProductID: Int?
    var mobileLinkAksiyaID: Int?
    var mobileLinkURL: String?
    var hasSubCategory: Bool?
    var mobileLinkSearchQuery: String?
    var staticPageId: String = ""
}

// MARK: - Category

struct CategoryResponse: Codable, Identifiable {
    var id: Int = 0
    var hasSubCategory: Bool = false
    var categoryImage: String?
    var image: String = ""
    var title: String = ""
}

// MARK: - HitProduct

struct HitProductResponse: Codable, Identifiable {
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var stik: StikResponse?
    var availability: AvailabilityResponse?
    var reviewsCount: String = ""
    var reviewsMiddleRate: CGFloat = 0
    var salePrice: Int = 0
    var fSalePrice: String = ""
    var loanPrice: Int = 0
    var fLoanPrice: String = ""
    var oldPrice: Double?
    var fOldPrice: String?
    var axiomMonthlyPrice: String = ""
    var kodProduct: String = ""
}

// MARK: - Stik

struct StikResponse: Codable, Identifiable {
    var id: Int = 0
    var title: TitleResponse
    var backround: BackroundResponse
    var color: ColorResponse
    var key: KeyResponse
    var icon: String = ""
}

enum BackroundResponse: String, Codable {
    case empty = "" // skidka
    case ff3600 = "#ff3600" // hitProducts
    case the333333 = "#333333" // zornarh
    case the3Aa847 = "#3aa847" // bozordan_arzon
    case the54C6Eb = "#54c6eb" // recommendedProducts
}

enum ColorResponse: String, Codable {
    case empty = ""
    case fec20F = "#fec20f"
    case fff = "#fff"
}

enum KeyResponse: String, Codable {
    case vaucherSovg = "vaucher_sovg"
    case hitProducts
    case recommendedProducts
    case skidka
    case zornarh
}

enum TitleResponse: String, Codable {
    case ваучер = "Ваучер" // vaucher
    case лучшаяЦена = "Лучшая цена" // zornarh
    case рекомендуем = "Рекомендуем" // recommendedProducts
    case скидка = "Скидка" // skidka
    case хитПродаж = "Хит продаж" // hitProducts
}

// MARK: - Availability

struct AvailabilityResponse: Codable {
    var type: TypeEnum
}

enum TypeEnum: String, Codable {
    case hasStores // Доступен магазинах
    case openToCart // В корзину
    case predzakaz
    case notAvailable

    var title: String {
        switch self {
        case .hasStores:
            return "Доступен \nв магизинах"
        case .openToCart:
            return "В корзину"
        case .predzakaz:
            return "Предзаказ"
        case .notAvailable:
            return "Недоступно"
        }
    }
}

// MARK: - SpecialCategoryProduct

struct SpecialCategoryProductResponse: Codable, Identifiable {
    var id: Int = 0
    var hasSubCategory: Bool = false
    var title: String = ""
    var items: [HitProductResponse] = []
}
