//
//  ListCategoriesResponse.swift
//  TexnomartiOS
//
//  Created by yns on 31.03.2022.
//

import Foundation

// MARK: - ListCategoriesResponse

struct ListCategoriesResponse: Codable {
    var success: Bool = false
    var errorCode: Int = 0
    var message: String = ""
    var data: [ListCategoriesDataResponse]
}

// MARK: - Datum

struct ListCategoriesDataResponse: Codable, Identifiable {
    var id: Int = 0
    var title: String = ""
    var mobileIcon: String?
    var image: String = ""
    var hasSubCategory: Bool = false
    var detailUrl: String = ""
    var detailUrlApi: String = ""
    var prettyNameForSearch: String = ""
    var isMainCategory: Int = 0
}
