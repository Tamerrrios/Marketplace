//
//  CatalogRepository.swift
//  TexnomartiOS
//
//  Created by yns on 30.03.2022.
//

import Alamofire
import Combine
import Foundation
import UIKit

struct CatalogRepository: WebRepositoryProtocol {
    var baseURL: String = Consts.URL
    static let sharedManager = CatalogRepository()

    func getAllMainCategories(_ handler: @escaping (String?) -> Void) ->
        AnyPublisher<MainCategoriesResponse, AFError>
    {
        return callWithoutParams(endpoint: APICase.mainCategories, decoderStrategy: .convertFromSnakeCase) { response in
            if response != nil {
                handler(response)
            }
        }
    }

    func getListCategories(categoryId: Int, _ handler: @escaping (String?) -> Void) ->
        AnyPublisher<ListCategoriesResponse, AFError>
    {
        return callWithoutParams(endpoint: APICase.listCategories(categoryId), decoderStrategy: .convertFromSnakeCase) { response in
            if response != nil {
                handler(response)
            }
        }
    }

    func getCategoryProducts(params: [String: String], _ handler: @escaping (String?) -> Void) ->
        AnyPublisher<CategoryProductsResponse, AFError>
    {
        return callWithoutParams(endpoint: APICase.getCategoryProducts(params), decoderStrategy: .convertFromSnakeCase) { response in
            if response != nil {
                handler(response)
            }
        }
    }
}

extension CatalogRepository {
    enum APICase {
        case mainCategories
        case listCategories(Int)
        case getCategoryProducts([String: String])
    }
}

extension CatalogRepository.APICase: APICall {
    var path: String {
        switch self {
        case .mainCategories:
            return "category/index"
        case let .listCategories(categoryId):
            return "category/list?category_id=\(String(categoryId))"
        case let .getCategoryProducts(params):
            return URLBuilder.buildQuery(path: "category/products", queryParams: params)
        }
    }

    var method: HTTPMethod {
        switch self {
        case .mainCategories, .listCategories, .getCategoryProducts:
            return .get
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .mainCategories, .listCategories, .getCategoryProducts:
            return [
                "Accept-Language": "ru",
                "Cookie": "PHPSESSID=mism3mbfo4g27furj41okmpejb",
            ]
        }
    }
}
