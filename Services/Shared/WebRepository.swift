//
//  WebRepository.swift
//  TexnomartiOS
//
//  Created by yns on 23.03.2022.
//

import Alamofire
import Combine
import Foundation
import UIKit

protocol WebRepositoryProtocol {
    var baseURL: String { get }
}

extension WebRepositoryProtocol {
    // MARK: call with params

    func callWithParams<Input, Output>(
        endpoint: APICall,
        httpCodes _: HTTPCodes = .success,
        params: Input?,
        decoderStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        _ handler: @escaping (String?) -> Void
    ) -> AnyPublisher<Output, AFError> where Input: Codable, Output: Codable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = decoderStrategy
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL, params: params) { res in
                if res != nil {
                    handler(res)
                }
            }
            let result = request.publishDecodable(type: Output.self, decoder: decoder)
            return result.value()
        } catch {
            return Fail<Output, AFError>(error: error.asAFError(orFailWith: "error fail")).eraseToAnyPublisher()
        }
    }

    // MARK: call without params

    func callWithoutParams<Output>(
        endpoint: APICall,
        httpCodes _: HTTPCodes = .success,
        decoderStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        _ handler: @escaping (String?) -> Void
    ) -> AnyPublisher<Output, AFError>
        where Output: Codable
    {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = decoderStrategy
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL) { res in
                if res != nil {
                    handler(res)
                }
            }
            let result = request.publishDecodable(type: Output.self, decoder: decoder)
            return result.value()
        } catch {
            return Fail<Output, AFError>(error: error.asAFError(orFailWith: "error fail")).eraseToAnyPublisher()
        }
    }
}

extension WebRepositoryProtocol {
    func loginRequest<Output: Codable>(
        endpoint: APICall, params: [String: String],
        decoderStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        _ handler: @escaping (String?
        ) -> Void
    ) -> AnyPublisher<Output, AFError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = decoderStrategy
        do {
            let request = try endpoint.loginRequest(baseURL: baseURL, params: params) { res in
                if res != nil {
                    handler(res)
                }
            }
            let result = request.publishDecodable(type: Output.self, decoder: decoder)
            return result.value()
        } catch {
            return Fail<Output, AFError>(error: error.asAFError(orFailWith: "error fail")).eraseToAnyPublisher()
        }
    }
}
