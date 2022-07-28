//
//  APICall.swift
//  TexnomartiOS
//
//  Created by yns on 23.03.2022.
//

import Alamofire
import Foundation
import UIKit

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
    static let serverError = 500 ..< 526
    static let invalidToken = 401
}

protocol APICall {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}

extension APICall {
    private func handleRequest(response: AFDataResponse<Any>, _ handler: @escaping (String?) -> Void) {
        debugPrint("call with \(UUID())")
        guard let data = response.data else { return }
        handler(String(data: data, encoding: .utf8) ?? "")
    }

    func urlRequest(baseURL: String, _ handler: @escaping (String?) -> Void) throws -> DataRequest {
        guard let url = URL(string: baseURL + path) else {
            throw AFError.invalidURL(url: baseURL + path)
        }

        let request = API.shared.manager.request(url, method: method, headers: headers)
        request.responseString { res in
            guard let answer = res.response else { return }
            if HTTPCodes.success ~= answer.statusCode {
                handler(nil)
            } else {
                if HTTPCodes.invalidToken == answer.statusCode {
                    NotificationCenter.default.post(name: NSNotification.Name("logout"), object: nil)
                } else {
                    guard let data = res.data else {
                        return
                    }
                    handler(String(data: data, encoding: .utf8) ?? "")
                }
            }
        }
        return request
    }

    func urlRequest<T: Codable>(baseURL: String, params: T?, _ handler: @escaping (String?) -> Void) throws -> DataRequest {
        guard let url = URL(string: baseURL + path) else {
            throw AFError.invalidURL(url: baseURL + path)
        }
        let request = API.shared.manager.request(url, method: method, parameters: params, encoder: JSONParameterEncoder.default, headers: headers)

        request.responseString { res in
            guard let answer = res.response else { return }
            if HTTPCodes.success ~= answer.statusCode {
                handler(nil)
            } else {
                if HTTPCodes.serverError ~= answer.statusCode {
                    handler("Ошибка сервера")
                } else if HTTPCodes.invalidToken == answer.statusCode {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logout"), object: nil)
                } else {
                    guard let data = res.data else { return }
                    handler(String(data: data, encoding: .utf8) ?? "")
                }
            }
        }
        return request
    }

    func loginRequest(baseURL: String, params: [String: String], _ handler: @escaping (String?) -> Void) throws -> DataRequest {
        guard let url = URL(string: baseURL + path) else {
            throw AFError.invalidURL(url: baseURL + path)
        }

        let request = API.shared.manager.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, to: url, usingThreshold: UInt64(), method: method, headers: headers)
        request
            .responseJSON { res in
                DispatchQueue.main.async {
                    handleRequest(response: res, handler)
                }
            }
        return request
    }
}
