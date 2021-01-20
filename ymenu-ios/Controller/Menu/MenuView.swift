//
//  MenuView.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 16/12/2020.
//

import Foundation
import SwiftUI


struct MenuView: View {
    
    @ObservedObject var viewModel = MenuViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (alignment: VerticalAlignment.center, spacing: 0){
                        ForEach(viewModel.dishCategories, id: \._id) { category in
                            CategoriesTopBarView(label: category.name)
                            Spacer()
                        }
                    }
                    .padding(.leading, 20)
                }
                
                List {
                    ForEach(viewModel.dishCategories, id: \._id) { category in
                        Section(header: Text(category.name)){
                            ForEach(viewModel.dishes, id: \._id) { dish in
                                if dish.category_id == category._id {
                                    NavigationLink(destination: DetailsView()){
                                        Text(dish.name)
                                    }
                                }
                            }
                            .padding(0)
                        }
                    }
                    .navigationBarTitle("Restaurant name")
                    .padding(.top, 30)
                }
                .padding(.horizontal, -20)
            }
        }
    }
}

struct DetailsView: View {

    @ObservedObject var viewModel = MenuViewModel()

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
        MenuView()
    }
}
