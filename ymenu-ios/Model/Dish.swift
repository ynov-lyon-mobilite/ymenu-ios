//
//  Dish.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 25/11/2020.
//

import Foundation

struct Dish: Decodable {
    let name: String
    let price: Int
    let ingredients: [String]?
    let infos: String?
    let urlLogo: String?
    let urlModel: String?
    let restaurantId: Int
    let dishCategoryId: Int
}
