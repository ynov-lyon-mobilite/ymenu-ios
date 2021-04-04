//
//  RestaurantApiService.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 25/11/2020.
//

import Foundation

final class RestaurantApiService {
    func getRestaurant(completion: @escaping (Result<[Restaurant], Error>) -> Void) -> Void {
        Request()
            .setPath("/restaurants/user/history")
            .setMethod(.GET)
            .withAuthentication()
            .sendWithDecode([Restaurant].self, completion: completion)
    }
}

//final class DishApiService {
//    func getDishesByRestaurantId(_ RestaurantDTO: RestaurantDTO,completion: @escaping (Result<[Dish], Error>) -> Void) -> Void {
//        Request()
//            .setPath("/dishes/restaurant/" + RestaurantDTO._id)
//            .setMethod(.GET)
//            .sendWithDecode([Dish].self, completion: completion)
//    }

