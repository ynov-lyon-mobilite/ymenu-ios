//
//  MenuView.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 16/12/2020.
//

import Foundation
import SwiftUI

struct Menu: View {
    
    @ObservedObject var viewModel = MenuViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.dishes, id: \._id) { dish in
                Text(dish.name)
            }
        }
    }
}
