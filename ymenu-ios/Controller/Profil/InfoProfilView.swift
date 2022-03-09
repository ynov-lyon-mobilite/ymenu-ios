//
//  InfoProfilView.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 31/03/2021.
//

import SwiftUI

struct InfoProfilView: View {
    // MARK: - Propertiers
    var body: some View {
            ScrollView {
                Image(systemName:"person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                VStack(alignment: .leading, spacing: 15){
                    VStack(alignment: .leading){
                        Text("Prénom")
                            .padding(.top, 10)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            Text(UserDefaults.standard.string(forKey: "firstname")!)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .opacity(0.5)
                        }.padding(.top, 10)
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Nom")
                            .padding(.top, 10)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            Text(UserDefaults.standard.string(forKey: "lastname")!)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .opacity(0.5)
                        }.padding(.top, 10)
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Adresse mail")
                            .padding(.top, 10)
                        HStack{
                            Image (systemName: "envelope").opacity((0.5))
                            
                            Text(UserDefaults.standard.string(forKey: "mail")!)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .opacity(0.5)
                        }.padding(.top, 10)
                        Divider()
                    }
                }.padding([.leading, .trailing], 27.5)
            }.navigationBarTitle(Text("Mes informations"), displayMode: .automatic)
   }
}

struct InfoProfilView_Previews: PreviewProvider {
    static var previews: some View {
        InfoProfilView()
    }
}

