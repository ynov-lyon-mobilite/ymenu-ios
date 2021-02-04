//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI

struct DishDetailView: View {

    @State var dish: Dish

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(dish.name)
                    .padding(.trailing, 5)
            }
        }
        .padding()
        .navigationBarTitle(Text("Détails du produit"), displayMode: .inline)
    }
}
