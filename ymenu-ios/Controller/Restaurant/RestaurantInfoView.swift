//
//  RestaurantInfoView.swift
//  ymenu-ios
//
//  Created by Mattéo Dinville on 09/03/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantInfoView: View {
    var numberOfImages = 3
    @ObservedObject var viewModel: RestaurantInfoViewModel
    @Binding var presentRestaurant: Bool
    var restaurantDTO: RestaurantDTO

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    ImageCarouselView(numberOfImages: 3) {
                        WebImage(url: URL(string: viewModel.restaurant.url_logo))
                            .onSuccess { image, data, cacheType in
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                        WebImage(url: URL(string: viewModel.restaurant.url_logo))
                            .onSuccess { image, data, cacheType in
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                        WebImage(url: URL(string: viewModel.restaurant.url_logo))
                            .onSuccess { image, data, cacheType in
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }.frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
                VStack(){
                    HStack(){
                        Text(viewModel.restaurant.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(10)
                       
                        Spacer()
                    }.padding(10)
                    
                    HStack(){
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text(viewModel.restaurant.speciality)
                                .padding(.leading, 20)
                            HStack(){
                                Button(action: {
                                    
                                }) {
                                    Text("11h00 - 23h00")
                                        .font(.system(size: 18))
                                        .bold()
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(Color.themeTextField)
                                        .cornerRadius(8)
                                        .shadow(radius: 6, x: 3, y: 3)
                                        .padding(20)
                                }.disabled(true)
                            }
                        }
                        Spacer()
                    }
                    HStack(){
                        
                        Text("À propos ")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    VStack() {
                        Text("\(viewModel.restaurant.description)")
                            .font(.body)
                            .padding(10)
                            .padding(.leading, 10)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }.padding(.top, 7)
                    
                    Spacer()
                    HStack(){
                        Button(action: {
                            self.presentRestaurant.toggle()
                        }) {
                                    HStack {
                                        Text("Découvrir la carte")
                                            .bold()
                                    }.frame(maxWidth:.infinity)
                                }.padding()
                                .foregroundColor(.white)
                                .background(Color.themeTextField)
                                .cornerRadius(7)
                                .shadow(radius: 6, x: 3, y: 3)
                                .padding(50)
                    }.padding()
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }.onAppear { viewModel.fetchRestaurantInfo(restaurant: restaurantDTO) }
    }
}

//struct RestaurantInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
