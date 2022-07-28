//
//  UsersRepository.swift
//  TexnomartiOS
//
//  Created by yns on 03.07.2022.
//

import Alamofire
import Combine
import Foundation
import UIKit

protocol UsersProtocol {
    func sendGetOtpCodeRequest(params: GetOtpCodeRequest, _ handler: @escaping (String?) -> Void) -> AnyPublisher<GetOtpCodeResponse, AFError>
}

struct UsersRepository: WebRepositoryProtocol, UsersProtocol {
    var baseURL: String = Consts.URL

    static let sharedManager = UsersRepository()

    func sendGetOtpCodeRequest(params: GetOtpCodeRequest, _ handler: @escaping (String?) -> Void) -> AnyPublisher<GetOtpCodeResponse, AFError> {
        return callWithParams(endpoint: API.getOtpCode, params: params, decoderStrategy: .convertFromSnakeCase) { res in
            if res != nil {
                handler(res)
            }
        }
    }
}

extension UsersRepository {
    enum API {
        case getOtpCode
    }
}

extension UsersRepository.API: APICall {
    var path: String {
        switch self {
        case .getOtpCode:
            return "user/login-phone"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getOtpCode:
            return .post
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .getOtpCode:
            return []
        }
    }
}
