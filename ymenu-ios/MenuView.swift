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
        NavigationView {
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (alignment: VerticalAlignment.center, spacing: 0){
                        Text("  Les carnivores  ")
                            .underline(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, color: Color.red)
                            .lineLimit(1)
                           Spacer()
                        Text("  Les végétariens  ")
                            .lineLimit(1)
                        Spacer()
                        Text("  Les réductions  ")
                            .lineLimit(1)
                        Spacer()
                        Text("  Les fous  ")
                            .lineLimit(1)
                        Spacer()
                    }
                    
                }
                
                List {
                    Section(header: Text("Les carnivores")){
                        ForEach(viewModel.dishes, id: \._id) { dish in
                            NavigationLink(destination: DetailsView()){
                            Text(dish.name)
                            
                        }
                        }
                        .padding(10)
                        .navigationBarTitle("Plat restaurant")
                    }
                    Section(header: Text("Les végétariens")){
                        ForEach(viewModel.dishes, id: \._id) { dish in
                            NavigationLink(destination: DetailsView()){
                            Text(dish.name)
                            
                        }
                            .padding(10)
                            
                        }
                    }
                    
                    Section(header: Text("Les réductions")){
                        ForEach(viewModel.dishes, id: \._id) { dish in
                            NavigationLink(destination: DetailsView()){
                            Text(dish.name)
                            
                        }
                        .padding(10)
                    }
                    }
                    Section(header: Text("Les fous")){
                        ForEach(viewModel.dishes, id: \._id) { dish in
                            NavigationLink(destination: DetailsView()){
                            Text(dish.name)
                            
                        }
                        }
                        .padding(10)
                    }
                }
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
        
        ForEach(viewModel.dishes, id: \._id) { dish in
            Text(dish.name)
          .font(.largeTitle)
          .bold()
        }
        Spacer()
      }
      
      Text("description")
        .padding(.top)
      
      Spacer()
    }
    .padding()
    .navigationBarTitle(Text("Détails du produit"), displayMode: .inline)
  }
}
