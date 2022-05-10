//
//  MenuCardView.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 29/03/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct MenuCardView: View{
    var dishCategory: DishCategory
    var dishes: [Dish]
    @Binding var currentTab: String

    var body: some View{
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text(dishCategory.name)
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .padding(.vertical)
            
            ForEach(dishes.filter { $0.category_id == dishCategory._id }, id: \._id) { dish in

                ZStack{
                    Button("") {}
                    NavigationLink(destination: DishDetailView(dish: dish)){
                        ZStack {
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
                                .frame(width: 135, height: 150, alignment: .center)
                                .cornerRadius(13)
                                .frame(maxWidth: 149, alignment: .leading)
                                .shadow(radius: 6, x: 3, y: 3)
                            if (dish.url_model_ios != "") {
                                Image(systemName: "arkit")
                                    .font(.system(size: 16, weight: .light, design: .rounded))
                                    .padding(5)
                                    .background(
                                        Blur(style: .systemUltraThinMaterial)
                                    ).cornerRadius(13).offset(x: -50, y: -50)
                                    .foregroundColor(.primary)
                            }
                        }

                    VStack(alignment: .leading, spacing: 10) {
                        Text(dish.name)
                            .multilineTextAlignment(.leading)
                            .font(.title3.bold())
                            .foregroundColor(.themeTextField)

                        if (dish.ingredients?.count != 0) {
                            Text(dish.ingredients?.joined(separator: ", ") ?? "")
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                        }

                        Text("\(String(describing: dish.price))0 €").font(.callout).bold()
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 3)
                            .padding(.horizontal, 5)
                            .background(
                              RoundedRectangle(cornerRadius: 6).foregroundColor(Color.themeTextFieldAlt)
                            ).foregroundColor(.white)
                            .padding(.top, 5)
                            
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Divider()
            }
        }
        .modifier(OffsetModifier(dishCategory: dishCategory, currentTab: $currentTab))
        .id(dishCategory.name)
    }
        
}
