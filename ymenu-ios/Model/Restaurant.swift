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
    let address: String
    let zipcode: String
    let city: String
    let phone: Int
    let name: String
    let mail: String
    let url_logo: String
    let description: String
    let speciality: String
}
