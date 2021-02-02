//
//  DishApiService.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 25/11/2020.
//

import Foundation

final class DishApiService {
    func getDishesByRestaurantId(_ RestaurantDTO: RestaurantDTO,completion: @escaping (Result<[Dish], Error>) -> Void) -> Void {
        Request()
            .setPath("/dishes/" + RestaurantDTO._id)
            .setMethod(.GET)
            .sendWithDecode([Dish].self, completion: completion)
    }
}
