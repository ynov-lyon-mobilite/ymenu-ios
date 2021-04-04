//
//  MenuViewModel.swift
//  ymenu-ios
//
//  Created by Antoine MOUSSET on 31/03/2021.
//

import Foundation

final class HistoryViewModel : ObservableObject {
    @Published var restaurants: [Restaurant] = []
    
//    var selectedCategory: DishCategory? {
//        get {
//            guard let category = dishCategories.first(where: { $0._id == selectedCategoryId }) else { return nil }
//
//            return category
//        }
//    }
    let restaurantApiService = RestaurantApiService()
    
    init() {
        
        restaurantApiService.getRestaurant() { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let restaurants):
                DispatchQueue.main.async {
                    print(restaurants)
//                    strongSelf.restaurants.append(contentsOf: restaurants)
                }
            case .failure(let error):
//                print("Failed getting restaurants")
            print(error)
            }
        }
        
//        dishCategoryApiService.getDisheCategoriesByRestaurantId(restaurant) { [weak self] in
//            guard let strongSelf = self else { return }
//
//            switch $0 {
//            case .success(let dishCategories):
//                DispatchQueue.main.async {
//                    strongSelf.dishCategories.append(contentsOf: dishCategories)
//                }
//            case .failure(_):
//                print("failed getting dish categories for restaurant " + self!.restaurant._id)
//            }
//        }
    }
}
