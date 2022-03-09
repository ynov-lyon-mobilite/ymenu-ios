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
        NavigationView {
            VStack {
                Image(systemName:"person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 35).foregroundColor(.white))
                Text("Mes Informations").font(.system(size: 25))
                    .padding()

                VStack(alignment: .leading, spacing: 15){
                    VStack(alignment: .leading){
                        Text("Civilité")
                            .padding(10)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            Text("Monsieur")
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .opacity(0.5)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Nom d'utilisateur").padding()
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            Text("Zakarya_Tolba")
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .opacity(0.5)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Prénom").padding(10)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            Text("Zakarya")
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .opacity(0.5)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Nom").padding(10)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            Text("Tolba")
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .opacity(0.5)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Adresse mail").padding(10)
                        HStack{
                            Image (systemName: "envelope").opacity((0.5))
                            
                            Text("Adresse mail")
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .opacity(0.5)
                        }
                        Divider()
                    }.navigationBarItems(leading:
                        Button(action: {
                        }) {
                            Text("Retour").accentColor(Color.themeTextField)
                        }
                    )
                }.padding([.leading, .trailing], 27.5)
            }
        }
   }
}

struct InfoProfilView_Previews: PreviewProvider {
    static var previews: some View {
        InfoProfilView()
    }
}

