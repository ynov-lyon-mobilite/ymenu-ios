//
//  DishCategoryApiService.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import Foundation

final class DishCategoryApiService {
    func getDisheCategoriesByRestaurantId(_ RestaurantDTO: RestaurantDTO,completion: @escaping (Result<[DishCategory], Error>) -> Void) -> Void {
        Request()
            .setPath("/dishCategories/restaurant/" + RestaurantDTO._id)
            .setMethod(.GET)
            .sendWithDecode([DishCategory].self, completion: completion)
    }
}
