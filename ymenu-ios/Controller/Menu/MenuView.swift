//
//  MenuView.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 16/12/2020.
//

import Foundation
import SwiftUI
import Combine

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
                                }
                                Spacer()
                            }
                        }
                        .padding(.leading, 20)
                    }
                    
                    List {
                        IndexedForEach(viewModel.dishCategories) { index, category in
                                ForEach(viewModel.dishes.filter { $0.category_id == category._id }, id: \._id) { dish in
                                            Button("") {}
                                            NavigationLink(destination: DishDetailView(dish: dish)){
                                                
                                                Text(dish.name)
                                            }
                                        }
                                        
                                    }
                                }
                            }.id(category._id)
                        }
                        .navigationBarTitle(self.viewModel.restaurant.name)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .padding(.horizontal, -20)

                }.gesture(
                    DragGesture().onChanged { value in
                        print(value.location.y)
                    }
                 )
            }
        }
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
