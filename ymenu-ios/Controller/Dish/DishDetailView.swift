//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI

struct DishDetailView: View {

    @State var dish: Dish
    @ObservedObject var viewModel = MenuViewModel()
   

    var body: some View {
        VStack(alignment: .leading) {
           
            HStack {
                List {
                    let ingredients = dish.ingredients
                        Text(dish.name)
                            .font(.system(size: 26, weight: .bold, design: .default))
                            .foregroundColor(Color.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                    Text("Ingrédients:")
                        .font(.system(size: 17, weight: .bold, design: .default))
                    ForEach(ingredients!, id: \.self) { ingredient in
                                   Text(ingredient)
                               }
                    .padding(.trailing, 5)
                }
                .padding(.horizontal, -20)
            }
        }
        .padding()
        .navigationBarTitle(Text("Détails du produit"), displayMode: .inline)
    }
}
