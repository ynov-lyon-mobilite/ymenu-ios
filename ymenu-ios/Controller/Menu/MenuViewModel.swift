//
//  MenuViewModel.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 16/12/2020.
//

import Foundation

final class MenuViewModel : ObservableObject {
    @Published var dishes: [Dish] = []
    @Published var dishCategories: [DishCategory] = []
    let dishApiService = DishApiService()
    let dishCategoryApiService = DishCategoryApiService()
    
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
        
        dishCategoryApiService.getDisheCategoriesByRestaurantId(restaurant) { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let dishCategories):
                strongSelf.dishCategories.append(contentsOf: dishCategories)
            case .failure(_):
                print("failed getting dish categories for restaurant " + restaurant._id)
            }
        }
    }
}
