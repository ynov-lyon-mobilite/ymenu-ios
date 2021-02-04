//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DishDetailView: View {
    var dish: Dish
    @State var isPresented = false
    
    init(dish: Dish) {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name:"SF Pro Rounded Bold", size: 10)!
        ]
        
        self.dish = dish
    }

    var body: some View {
        let ingredients = dish.ingredients
        
        VStack(alignment: .leading) {
            ZStack {
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
                            .frame(width: UIScreen.main.bounds.size.width - 30, height: 280, alignment: .center)
                            .cornerRadius(30)
                            .shadow(radius: 6, x: 3, y: 3)
                        HStack {
                            Text(dish.name)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .font(.custom("SF Pro Text Bold", fixedSize: 22))
                            Spacer()
                            Text("\(String(describing: dish.price))0 €")
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .font(.custom("SF Pro Text Regular", fixedSize: 20))
                        }
                        Text("Ingrédients:")
                            .font(.custom("SF Pro Text Bold", fixedSize: 17))
                        ForEach(ingredients!, id: \.self) { ingredient in
                            Text(ingredient)
                                .font(.custom("SF Pro Text Regular", fixedSize: 17))
                        }
                        .padding(.trailing, 5)
                   }.padding(.horizontal, -20)
                }
                Button(action: {
                    self.isPresented = true
                }) {
                HStack {
                    Image(systemName: "arkit")
                    Text("Voir en RA")
                        .bold()
                }}
                .padding()
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(.greatestFiniteMagnitude)
                .sheet(isPresented: $isPresented) {
                    ZStack (alignment: .topLeading){
                        ARQuickLookView(fileName: "minuteasia_bobun", title: "Bobun", isPresented: self.$isPresented).edgesIgnoringSafeArea(.bottom)
                        HStack (alignment: .top){
                            VStack (alignment: .leading) {
                                Button(action: {
                                 self.isPresented = false
                                }, label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 25, weight: .light, design: .rounded))
                                    .padding(.horizontal, 19)
                                    .padding(.vertical, 12)
                                    .background(
                                        Blur(
                                             style: .systemThinMaterial)
                                        )
                                }).buttonStyle(PlainButtonStyle()).cornerRadius(14).padding(14).padding(.top, 11)
                             }
                         }
                    }
                }.shadow(radius: 5, x: 2, y: 2)
                .frame(maxHeight: .infinity, alignment: .bottom)
                Spacer()
            }
        }
        .padding()
        .navigationBarTitle(Text("Détails du produit"), displayMode: .automatic)
    }
}
