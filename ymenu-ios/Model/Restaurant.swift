//
//  Restaurant.swift
//  ymenu-ios
//
//  Created by Antoine Mousset on 04/04/2021.
//

import Foundation
import SwiftUI

struct Restaurant: Hashable, Decodable {
    let _id: String
    let name: String
    let url_logo: String
    let address: String
    let updatedAt: String
    let description: String
    let speciality: String
    let schedules: [String]
}
