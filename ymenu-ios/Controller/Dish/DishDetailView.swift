//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DishDetailView: View {

    @State var dish: Dish
    @ObservedObject var viewModel = MenuViewModel(restaurant: RestaurantDTO(_id: "", name: ""))

    var body: some View {
        let ingredients = dish.ingredients
        
        VStack(alignment: .leading) {
           
            HStack {
                List {
                    WebImage(url: URL(string: dish.url_logo))
                      .onSuccess { image, data, cacheType in
                      }
                      .resizable()
                      .placeholder {
                          Rectangle().foregroundColor(.gray)
                      }
                      .indicator(.activity)
                      .transition(.fade(duration: 0.5))
                      .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 400, height: 280, alignment: .center)
                        .cornerRadius(30)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .shadow(radius: 6, x: 3, y: 3)
                    Text(dish.name)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
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
