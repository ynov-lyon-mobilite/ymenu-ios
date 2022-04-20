//
//  MenuViewModel.swift
//  ymenu-ios
//
//  Created by Antoine MOUSSET on 31/03/2021.
//

import Foundation
import Combine

final class RestaurantInfoViewModel : ObservableObject {
    @Published var restaurant: Restaurant = Restaurant(_id: "", address: "", zipcode: "", city: "", phone: 0, name: "", mail: "", url_logo: "", description: "", speciality: "")
    let restaurantApiService = RestaurantApiService()
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    
    private var presentRestaurant = false {
        didSet {
            viewDismissalModePublisher.send(presentRestaurant)
        }
    }
    
    func fetchRestaurantInfo(restaurant: RestaurantDTO) {
        restaurantApiService.getRestaurant(restaurant) { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let restaurant):
                DispatchQueue.main.async {
                    strongSelf.restaurant = restaurant
                }
            case .failure(let error):
                print("Failed getting the restaurant details")
                print(error)
            }
        }
    }
}
