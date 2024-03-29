//
//  User.swift
//  QuestrFrogogo
//
//  Created by Евгений Бейнар on 18.10.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let email: String
    let avatar_url: String?
    let created_at: String
}

struct CreateUser: Encodable {
    let first_name: String
    let last_name: String
    let email: String
}
