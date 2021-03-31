//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI

struct ProfilView: View {
    @State var isPresented = false

    var body: some View {
        NavigationView{
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
            Text("Profil")
                .font(.custom("SF Pro Text Regular", size: 30))
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .offset(y: -90)
            }
            VStack{
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 300, height: 55)
                    .foregroundColor(Color.orange)
                    .padding()
                        .shadow(radius: 5, x: 2, y: 2)
                        .border(Color.black, width: 0)
                    .overlay(
                        NavigationLink(
                            destination: InfoProfilView(), // <3>
                                label: {
                                    Label("Mes informations", systemImage: "") // <7>
                                    })
                        .foregroundColor(.white)
                            .font(.custom("SF Pro Text Bold", size: 24))
                    ).offset(y:20)
                }
            
            VStack{
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 300, height: 55)
                    .foregroundColor(Color.orange)
                    .padding()
                        .shadow(radius: 5, x: 2, y: 2)
                        .border(Color.black, width: 0)
                    .overlay(
                        NavigationLink(
                            // destination: mettre view historique
                            destination: InfoProfilView(), // <3>
                                label: {
                                    Label("Historique de visite", systemImage: "") // <7>
                                    })
                        .foregroundColor(.white)
                            .font(.custom("SF Pro Text Bold", size: 24))
                    ).offset(y: 120)
                }
            .navigationBarTitle("Profil")
            .navigationBarHidden(true)
        }.edgesIgnoringSafeArea(.all)
        }.accentColor(.orange)
    }
}
struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
