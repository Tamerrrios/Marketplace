//
//  API.swift
//  TexnomartiOS
//
//  Created by yns on 23.03.2022.
//

import Alamofire
import Foundation

class API {
    static var shared = API()

    final class AlamofireLogger: EventMonitor {
        func requestDidResume(_ request: Request) {
            let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
            let message = """
            \n
            ⚡️ Request Started: \(request)
            ⚡️ Body Data: \(body)
            """
            debugPrint(message)
        }

        func request<Value>(_: DataRequest, didParseResponse response: AFDataResponse<Value>) {
            debugPrint("\n ⚡️-------------------------------------⚡️")
            debugPrint("\n ⚡️ Response Received: \(response.debugDescription)")
            debugPrint("\n ⚡️-------------------------------------⚡️")
        }
    }

    let manager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCredentialStorage = nil
        let manager = Session(
            configuration: configuration,
            serverTrustManager: ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: ["www.example.com": DisabledTrustEvaluator()]),
            eventMonitors: [AlamofireLogger()]
        )

        return manager
    }()

    func cancelRequested() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}
