//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilView: View {
    @State var isPresented = false


    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack {
                HStack {
                    List {
                        WebImage(url: URL(string: "https://e7.pngegg.com/pngimages/505/761/png-clipart-login-computer-icons-avatar-icon-monochrome-black.png"))
                          .onSuccess { image, data, cacheType in
                          }
                          .resizable()
                          .placeholder {
                              Circle().foregroundColor(.gray)
                          }
                          .indicator(.activity)
                          .transition(.fade(duration: 0.5))
                            .overlay(Circle().stroke(Color.white))
                          .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.size.width - 30, height: 280, alignment: .center)
                            .cornerRadius(1000)
                            .shadow(radius: 6, x: 3, y: 3)
                        HStack {
                            Text("Profil Utilisateur")
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .font(.custom("SF Pro Text Bold", fixedSize: 22))
                            Spacer()
                        }
                        Text("Antoine")
                            .font(.custom("SF Pro Text Bold", fixedSize: 17))
                        Text("Mousset")
                            .font(.custom("SF Pro Text Bold", fixedSize: 17))
                        Text("21 ans")
                            .font(.custom("SF Pro Text Bold", fixedSize: 17))
                   }.padding(.horizontal, -20)
                }
                   
                    Spacer()
                }
        .padding()
        }
    }
}
