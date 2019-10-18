//
//  ApiError.swift
//  QuestrFrogogo
//
//  Created by Евгений Бейнар on 18.10.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import Foundation

struct ApiStructError: Decodable {
    let code: ApiErrorCode
}

enum ApiErrorCode: Int, LocalizedError, Decodable {
    
    case code422 = 422
    case other = 1
    
    var errorDescription: String? {
        switch self {
            case .code422: return "body message"
            case .other: return "Something went wrong"
        }
    }
}
