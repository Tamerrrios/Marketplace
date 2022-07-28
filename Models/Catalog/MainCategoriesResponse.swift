//
//  MainCategoriesResponse.swift
//  TexnomartiOS
//
//  Created by yns on 30.03.2022.
//

import Foundation

// MARK: - MainCategoriesResponse

struct MainCategoriesResponse: Codable {
    var success: Bool = false
    var errorCode: Int = 0
    var message: String = ""
    var data: [MainCategoriesDataResponse]
}

// MARK: - MainCategoriesDataResponse

struct MainCategoriesDataResponse: Identifiable, Codable {
    var id: Int = 0
    var title = ""
    var smallFrontIcon = ""
    var mobileIcon = ""
    var image: String = ""
    var hasSubCategory: Bool = false
}
