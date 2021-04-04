//
//  RestaurantApiService.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 25/11/2020.
//

import Foundation

final class RestaurantApiService {
    func getRestaurantByUserId(_ completion: @escaping (Result<[RestaurantDTO], Error>) -> Void) -> Void {
        Request()
            .setPath("/api/restaurants/user/history")
            .setMethod(.GET)
            .sendWithDecode([RestaurantDTO].self, completion: completion)
    }
}

//final class DishApiService {
//    func getDishesByRestaurantId(_ RestaurantDTO: RestaurantDTO,completion: @escaping (Result<[Dish], Error>) -> Void) -> Void {
//        Request()
//            .setPath("/dishes/restaurant/" + RestaurantDTO._id)
//            .setMethod(.GET)
//            .sendWithDecode([Dish].self, completion: completion)
//    }
