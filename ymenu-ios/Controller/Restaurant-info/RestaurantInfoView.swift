//
//  RestaurantInfoView.swift
//  ymenu-ios
//
//  Created by Mattéo Dinville on 09/03/2022.
//

import SwiftUI

struct RestaurantInfoView: View {
    private var numberOfImages = 3
    var body: some View {
        ZStack{
            //            Color("Color").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                //                Image("1")
                //                    .resizable()
                //                    .frame(height: UIScreen.main.bounds.height / 3)
                //                    .cornerRadius(30)
                GeometryReader { geometry in
                    ImageCarouselView(numberOfImages: 3) {
                        Image("1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                        Image("2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                        Image("3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }.frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
                VStack(){
                    
                    HStack(){
                        
                        Text("Minute Asia")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(10)
                        
                        Spacer()
                    }.padding(.top, 7)
                    
                    HStack(){
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text("€€ Restaurant asiatique")
                                .foregroundColor(.gray)
                                .padding(10)
                            HStack(){
                                Button(action: {
                                    
                                }) {
                                    Text("11h00 - 23h00")
                                        .font(.system(size: 15))
                                        .bold()
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(Color.themeTextField)
                                        .cornerRadius(20)
                                        .shadow(radius: 6, x: 3, y: 3)
                                        .padding(10)
                                }
                            }
                        }
                        Spacer()
                    }
                    HStack(){
                        
                        Text("A propos ")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(10)
                        
                        Spacer()
                    }.padding(.top, 7)
                    
                    HStack(){
                        
                        Text("A travers cette application vous pourrez découvrir les différents menus ainsi que leurs plats en réalité augmentée. Visualiez votre plat sur votre table avant même de l'avoir commandé")
                            .padding(10)
                        Spacer()
                    }.padding(.top, 7)
                    
                    Spacer()
                    HStack(){
                        Button(action: {
                            
                        }) {
                            Text("Découvrir la carte")
                                .font(.title)
                                .bold()
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.themeTextField)
                                .cornerRadius(20)
                                .shadow(radius: 6, x: 3, y: 3)
                        }
                    }.padding()
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct RestaurantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoView()
    }
}
