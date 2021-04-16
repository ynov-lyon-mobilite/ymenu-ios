//
//  RestaurantApiService.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 25/11/2020.
//

import Foundation

final class RestaurantApiService {
    func getRestaurant(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        Request()
            .setPath("/restaurants/user/history")
            .setMethod(.GET)
            .withAuthentication()
            .sendWithDecode([Restaurant].self, completion: completion)
    }
    
    func addRestaurantToHistory(_ RestaurantDTO: RestaurantDTO, completion: @escaping (Result<NSNull, Error>) -> Void) {
        Request()
            .setPath("/user/history/" + RestaurantDTO._id)
            .setMethod(.POST)
            .withAuthentication()
            .send(completion: completion)
    }
}
