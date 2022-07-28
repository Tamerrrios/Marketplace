//
//  ViewedProductsResponse.swift
//  TexnomartiOS
//
//  Created by yns on 28.03.2022.
//

import Foundation
import SwiftUI

// MARK: - ViewedProductsResponse

struct ViewedProductsResponse: Codable {
    var success: Bool
    var errorCode: Int
    var message: String
    var data: [HitProductResponse]
}
