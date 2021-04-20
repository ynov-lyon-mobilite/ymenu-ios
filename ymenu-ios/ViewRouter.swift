//
//  SelectedTab.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 09/04/2021.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: String = "qrcode.viewfinder"
    @Published var restaurant: RestaurantDTO = RestaurantDTO(_id: "", name: "")
}
