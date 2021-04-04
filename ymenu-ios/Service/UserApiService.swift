//
//  UserApiService.swift
//  ymenu-ios
//
//  Created by Antoine Mousset on 04/04/2021.
//

import Foundation


final class UserApiService {
    func getRestaurantByUserId(_ completion: @escaping (Result<[UserDTO], Error>) -> Void) -> Void {
        Request()
            .setPath("/api/restaurants/user/history")
            .setMethod(.GET)
            .sendWithDecode([UserDTO].self, completion: completion)
            .withAuthentication()
            .addValue("Bearer \(safeToken)", forHTTPHeaderField: "Authorization")
    }
}
