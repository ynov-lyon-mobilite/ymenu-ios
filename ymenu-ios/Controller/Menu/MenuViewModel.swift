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
    @Published var selectedCategoryId: String = ""
    @Published var restaurant: RestaurantDTO
    
    var selectedCategory: DishCategory? {
        get {
            guard let category = dishCategories.first(where: { $0.name == selectedCategoryId }) else { return nil }
            
            return category
        }
    }
    let dishApiService = DishApiService()
    let dishCategoryApiService = DishCategoryApiService()
    
    init(restaurant: RestaurantDTO) {
        self.restaurant = restaurant
        
        dishApiService.getDishesByRestaurantId(restaurant) { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let dishes):
                DispatchQueue.main.async {
                    strongSelf.dishes.append(contentsOf: dishes)
                }
            case .failure(_):
                print("failed getting dishes for restaurant " + self!.restaurant._id)
            }
        }
        
        dishCategoryApiService.getDisheCategoriesByRestaurantId(restaurant) { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let dishCategories):
                DispatchQueue.main.async {
                    strongSelf.dishCategories.append(contentsOf: dishCategories)
                }
            case .failure(_):
                print("failed getting dish categories for restaurant " + self!.restaurant._id)
            }
        }
    }
}
