//
//  RestaurantApiService.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 25/11/2020.
//

import Foundation

final class RestaurantApiService {
    func getRestaurantByUserId(_ UserDTO: UserDTO,completion: @escaping (Result<[Restaurant], Error>) -> Void) -> Void {
        Request()
            .setPath("api/user/history")
            .setMethod(.GET)
            .sendWithDecode([Restaurant].self, completion: completion)
    }
}
