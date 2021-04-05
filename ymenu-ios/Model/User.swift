//
//  User.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 31/03/2021.
//

import Foundation

struct User: Decodable {
    let isActive: Bool
    let history: [String]
    let mail: String
    let password: String
    let firstname: String
    let lastname: String
    let role: String
    let createdAt: Date
    let updatedAt: Date
}
