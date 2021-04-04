//
//  MenuViewModel.swift
//  ymenu-ios
//
//  Created by Antoine MOUSSET on 31/03/2021.
//

import Foundation

final class HistoryViewModel : ObservableObject {
    @Published var user: UserDTO
    
//    var selectedCategory: DishCategory? {
//        get {
//            guard let category = dishCategories.first(where: { $0._id == selectedCategoryId }) else { return nil }
//
//            return category
//        }
//    }
    let restaurantApiService = RestaurantApiService()
    
    init(user: UserDTO) {
        self.user = user
        
        UserApi.getRestaurantByUserId(user) { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let restaurant):
                DispatchQueue.main.async {
                    strongSelf.restaurant.append(contentsOf: dishes)
                }
            case .failure(_):
                print("failed getting user for restaurant " + self!.user._id)
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
