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
                 {
                    Text("Email")
                        .frame(width: 270, height: 25)
                        .font(.custom("SF Pro Text Regular", size: 22))
                        .padding()
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.orange, lineWidth: 2)
                        )
                }().offset(y: 25)
            }
            VStack{
                 {
                    Text("Nom")
                        .frame(width: 270, height: 25)
                        .font(.custom("SF Pro Text Regular", size: 22))
                        .padding()
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.orange, lineWidth: 2)
                        )
                }().offset(y: 125)
            }
            VStack{
                 {
                    Text("Prénom")
                        .frame(width: 270, height: 25)
                        .font(.custom("SF Pro Text Regular", size: 22))
                        .padding()
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.orange, lineWidth: 2)
                        )
                 }().offset(y: 225)
            }
        }.edgesIgnoringSafeArea(.all)
    }
    }

struct InfoProfilView_Previews: PreviewProvider {
    static var previews: some View {
        InfoProfilView()
    }
}
