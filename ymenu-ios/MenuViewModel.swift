//
//  MenuViewModel.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 16/12/2020.
//

import Foundation

final class MenuViewModel : ObservableObject {
    @Published var dishes: [Dish] = []
    let dishApiService = DishApiService()
    
    init() {
        let restaurant = RestaurantDTO(_id: "5fbe1e3b6f87600017ff108d")
        
        dishApiService.getDishesByRestaurantId(restaurant) { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let dishes):
                strongSelf.dishes.append(contentsOf: dishes)
            case .failure(_):
                print("failed getting dishes for restaurant " + restaurant._id)
            }
        }
    }
}
