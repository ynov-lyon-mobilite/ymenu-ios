//
//  MenuViewModel.swift
//  ymenu-ios
//
//  Created by Antoine MOUSSET on 31/03/2021.
//

import Foundation

final class HistoryViewModel : ObservableObject {
    @Published var restaurants: [Restaurant] = []
    
    let restaurantApiService = RestaurantApiService()
    
    init() {
        
        restaurantApiService.getRestaurant() { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let restaurants):
                DispatchQueue.main.async {
                    strongSelf.restaurants.append(contentsOf: restaurants)
                }
            case .failure(let error):
                print("Failed getting restaurants")
                print(error)
            }
        }
    }
}