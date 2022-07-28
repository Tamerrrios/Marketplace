//
//  CategoryProductsResponse.swift
//  TexnomartiOS
//
//  Created by yns on 05.04.2022.
//

import Foundation

struct CategoryProductsResponse: Codable {
    var success: Bool = false
    var errorCode: Int = 0
    var message: String = ""
    var data: CategoryDataProductsResponse
}

// MARK: - DataClass

struct CategoryDataProductsResponse: Codable {
    var products: ProductsResponse
    var filter: FilterResponse
}

// MARK: - Filter

struct FilterResponse: Codable {
    var minPrice: String = ""
    var maxPrice: String = ""
    var filterMaxPrice: Int = 0
    var filterMinPrice: String = ""
}

// MARK: - Products

struct ProductsResponse: Codable {
    var items: [HitProductResponse]
    var links: LinksResponse
    var meta: MetaResponse

    enum CodingKeys: String, CodingKey {
        case items
        case links = "_links"
        case meta = "_meta"
    }
}

// MARK: - Links

struct LinksResponse: Codable {
    var linksSelf: FirstResponse
    var first: FirstResponse
    var last: FirstResponse
    var next: FirstResponse?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case first, last, next
    }
}

// MARK: - First

struct FirstResponse: Codable {
    var href: String = ""
}

// MARK: - Meta

struct MetaResponse: Codable {
    var totalCount: Int = 0
    var pageCount: Int = 0
    var currentPage: Int = 0
    var perPage: Int = 0
}
