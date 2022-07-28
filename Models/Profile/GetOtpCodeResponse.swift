//
//  GetOtpCodeResponse.swift
//  TexnomartiOS
//
//  Created by yns on 03.07.2022.
//

import SwiftUI

struct GetOtpCodeResponse: Codable {
    var success: Bool = false
    var errorCode: Int = 0
    var message: String = ""
}
