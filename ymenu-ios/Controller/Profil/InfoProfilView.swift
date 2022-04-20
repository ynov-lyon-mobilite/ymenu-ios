//
//  InfoProfilView.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 31/03/2021.
//

import SwiftUI

struct InfoProfilView: View {
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Propertiers
    var body: some View {
            ScrollView {
                Image(systemName:"person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding([.top, .bottom], 10)
                
                VStack(alignment: .leading, spacing: 15){
                    VStack(alignment: .leading){
                        Text("Prénom")
                            .font(.headline).bold()
                            .padding(.top, 10)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            Text(UserDefaults.standard.string(forKey: "firstname") ?? "")
                                .autocapitalization(.none)
                                .opacity(0.5)
                                .padding(8)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Nom")
                            .font(.headline).bold()
                            .padding(.top, 10)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            Text(UserDefaults.standard.string(forKey: "lastname") ?? "")
                                .autocapitalization(.none)
                                .opacity(0.5)
                                .padding(8)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Adresse mail")
                            .font(.headline).bold()
                            .padding(.top, 10)
                        HStack{
                            Image (systemName: "envelope").opacity((0.5))
                            
                            Text(UserDefaults.standard.string(forKey: "mail") ?? "")
                                .autocapitalization(.none)
                                .opacity(0.5)
                                .padding(8)
                        }
                        Divider()
                    }
                }.padding([.leading, .trailing], 27.5)
            }.navigationBarTitle(Text("Mes informations"), displayMode: .inline)
            .toolbar {
                NavigationLink(
                    destination: EditInfoProfilView(viewModel: EditInfoProfilViewModel())) {
                        Text("Modifier")
                    }
            }
   }
}

struct InfoProfilView_Previews: PreviewProvider {
    static var previews: some View {
        InfoProfilView()
    }
}

