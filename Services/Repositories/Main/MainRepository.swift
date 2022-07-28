//
//  MainRepository.swift
//  TexnomartiOS
//
//  Created by yns on 23.03.2022.
//

import Alamofire
import Combine
import Foundation
import UIKit

struct MainRepository: WebRepositoryProtocol {
    var baseURL: String = Consts.URL
    static let sharedManager = MainRepository()

    func getMainInfo(_ handler: @escaping (String?) -> Void) -> AnyPublisher<HomeResponse, AFError> {
        return callWithoutParams(endpoint: APICase.mainInfo, decoderStrategy: .convertFromSnakeCase) { response in
            if response != nil {
                handler(response)
            }
        }
    }

    func viewedProducts(params: [String], _ handler: @escaping (String?) -> Void) ->
        AnyPublisher<ViewedProductsResponse, AFError>
    {
        return callWithParams(
            endpoint: APICase.recently,
            params: params, decoderStrategy: .convertFromSnakeCase
        ) { res in
            if res != nil {
                handler(res)
            }
        }
    }
}

extension MainRepository {
    enum APICase {
        case mainInfo
        case recently
    }
}

extension MainRepository.APICase: APICall {
    var path: String {
        switch self {
        case .mainInfo:
            return "home/"
        case .recently:
            return "home/recently"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .mainInfo:
            return .get
        case .recently:
            return .post
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .mainInfo, .recently:
            return [
                "Accept-Language": "ru",
                "Region-Filter": "2",
                "Cookie": "PHPSESSID=mism3mbfo4g27furj41okmpejb",
            ]
        }
    }
}
