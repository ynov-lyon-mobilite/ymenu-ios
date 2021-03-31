//
//  InfoProfilView.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 31/03/2021.
//

import SwiftUI

struct InfoProfilView: View {
    var body: some View {
        ZStack{
            Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.1))
                    .edgesIgnoringSafeArea(.all)
            VStack{
                Image("logoymenu")
                .resizable()
                .aspectRatio(contentMode: .fit)
                    .frame(width: 135, height: 135, alignment: .center)
                .padding(.top)
                .padding(.bottom)
                .offset(y: -230)
            }
            VStack{
                Image("profil")
                .resizable()
                .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40, alignment: .center)
                .padding(.top)
                .padding(.bottom)
                .offset(y: -320)
                .offset(x: 160)
            }
            VStack{
            Text("Mes informations")
                .font(.custom("SF Pro Text Regular", size: 30))
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .offset(y: -90)
            }
            VStack{
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 300, height: 55)
    //                    .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                    .foregroundColor(Color.orange)
                    .padding()
                        .shadow(radius: 5, x: 2, y: 2)
                        .border(Color.black, width: 0)
                    .overlay(
                        Text("Nom")
                        .foregroundColor(.white)
                            .font(.custom("SF Pro Text Bold", size: 24))
                    ).offset(y:20)
            }.padding()
            VStack{
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 300, height: 55)
    //                    .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                    .foregroundColor(Color.orange)
                    .padding()
                        .shadow(radius: 5, x: 2, y: 2)
                        .border(Color.black, width: 0)
                    .overlay(
                        Text("Prénom")
                        .foregroundColor(.white)
                            .font(.custom("SF Pro Text Bold", size: 24))
                    ).offset(y:110)
            }.padding()
            VStack{
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 300, height: 55)
    //                    .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                    .foregroundColor(Color.orange)
                    .padding()
                        .shadow(radius: 5, x: 2, y: 2)
                        .border(Color.black, width: 0)
                    .overlay(
                        Text("Email")
                        .foregroundColor(.white)
                            .font(.custom("SF Pro Text Bold", size: 24))
                    ).offset(y:200)
            }.padding()
        }.edgesIgnoringSafeArea(.all)
    }
    }

struct InfoProfilView_Previews: PreviewProvider {
    static var previews: some View {
        InfoProfilView()
    }
}
