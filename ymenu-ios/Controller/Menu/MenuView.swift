//
//  MenuView.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 16/12/2020.
//

import Foundation
import SwiftUI
import Combine
import SDWebImageSwiftUI

struct MenuView: View {
    
    @ObservedObject var viewModel: MenuViewModel
    @State var scrollPosition: CGFloat = 0.0
    var bag = Set<AnyCancellable>()
    
    init(restaurant: RestaurantDTO) {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name:"SF Pro Rounded Bold", size: 40)!
        ]
        
        self.viewModel = MenuViewModel(restaurant: restaurant)
    }

    var body: some View {
        
        NavigationView {
            ScrollViewReader { proxy in
                VStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (alignment: VerticalAlignment.center, spacing: 5){
                            IndexedForEach(viewModel.dishCategories) { index, category in
                                Button(action: {
                                    withAnimation {
                                    proxy.scrollTo(category._id, anchor: .top)
                                    }
                                    viewModel.selectedCategoryId = category._id
                                }) {
                                    Text(category.name)
                                        .overlay(viewModel.selectedCategory?._id == category._id ? RoundedRectangle(cornerRadius: .infinity).shadow(color: Color.red, radius: 2.5, x: 0, y: 1).foregroundColor(Color.red).frame(height: 3).offset(y: 5) : nil, alignment: .bottom)
                                        .foregroundColor(Color.black)
                                        .padding(.top, 12)
                                        .padding(.bottom, 12)
                                }
                                Spacer()
                                Divider()
                                Spacer()
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 20)
                    }
                    
                    List {
                        IndexedForEach(viewModel.dishCategories) { index, category in
                            Section(header: Text(category.name).padding(.leading, 20).padding(.bottom, -10)){
                                ForEach(viewModel.dishes.filter { $0.category_id == category._id }, id: \._id) { dish in
                                        ZStack{
                                            Button("") {}
                                            NavigationLink(destination: DishDetailView(dish: dish)){
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
                                                    .frame(width: 126, height: 83, alignment: .center)
                                                    .cornerRadius(13)
                                                    .frame(maxWidth: .infinity, alignment: .center)
                                                    .shadow(radius: 6, x: 3, y: 3)
                                                Text(dish.name).multilineTextAlignment(.leading)
                                                    .padding(.leading, 10)
                                                Spacer()
                                                Text("\(String(describing: dish.price))0 €").bold().multilineTextAlignment(.center)
                                                Spacer().frame(width: 5)
                                            }
                                    }
                                }
                            }.id(category._id)
                        }
                        .navigationBarTitle(self.viewModel.restaurant.name, displayMode: .automatic)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .padding(.horizontal, -20)
                }
            }
        }.accentColor( .red)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(restaurant: RestaurantDTO(_id: "6007fabd63c8d10017d2b3ba", name: "Minute Asia"))

    }
}
