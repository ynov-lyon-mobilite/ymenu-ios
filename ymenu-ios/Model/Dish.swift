//
//  Dish.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 25/11/2020.
//

import Foundation

struct Dish: Decodable {
    let _id: String?
    let name: String
    let price: Int
    let ingredients: [String]?
    let infos: String?
    let url_logo: String?
    let url_model: String?
    let restaurant_id: String
    let category_id: String
}
