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

    var body: some View {
        
        NavigationView {
            ScrollViewReader { proxy in
                VStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (alignment: VerticalAlignment.center, spacing: 0){
                            IndexedForEach(viewModel.dishCategories) { index, category in
                                Button(action: {
                                    proxy.scrollTo(category._id, anchor: .top)
                                    viewModel.selectedCategoryId = category._id
                                }) {
                                    Text(category.name)
                                        .underline(viewModel.selectedCategory?._id == category._id, color: Color.red)
                                        .foregroundColor(Color.black)
                                        .padding(.top, 10)
                                }
                                Spacer()
                            }
                        }
                        .padding(.leading, 20)
                    }
                    
                    List {
                        IndexedForEach(viewModel.dishCategories) { index, category in
                            Section(header: Text(category.name).padding(.leading, 20).padding(.bottom, 1)){
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
                                                Spacer()
                                                Text(dish.name).multilineTextAlignment(.center)
                                                Spacer()
                                            }
                                    }
                                }
                            }.id(category._id)
                        }
                        .navigationBarTitle(self.viewModel.restaurant.name, displayMode: .large)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .padding(.horizontal, -20)
                }
            }
        }.navigationBarTitle(self.viewModel.restaurant.name, displayMode: .large)
    }
}

struct DetailsView: View {

    @ObservedObject var viewModel = MenuViewModel(restaurant: RestaurantDTO(_id: "", name: ""))

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("hello")
                    .padding(.trailing, 5)
            }
        }
        .padding()
        .navigationBarTitle(Text("Détails du produit"), displayMode: .inline)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewModel: MenuViewModel(restaurant: RestaurantDTO(_id: "6007fabd63c8d10017d2b3ba", name: "")))

    }
}
