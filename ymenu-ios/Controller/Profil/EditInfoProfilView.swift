//
//  EditInfoProfilView.swift
//  ymenu-ios
//
//  Created by Léo on 20/04/2022.
//

import SwiftUI

struct EditInfoProfilView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel: EditInfoProfilViewModel
    @State private var showSheet = false
    
    var body: some View {
            ScrollView {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120, alignment: .center)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding([.top, .bottom], 10)
                    .clipShape(Circle())
                    .cornerRadius(50)
                
                Button("Ajouter une photo") {
                    showSheet = true
                }
                
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
                .sheet(isPresented: $showSheet) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.image)
                }
            }.toolbar {
                Button("Ok") {
                    // TODO: SAVE IMAGE
                    presentationMode.wrappedValue.dismiss()
                }
            }
   }
}

struct EditInfoProfilView_Previews: PreviewProvider {
    static var previews: some View {
        EditInfoProfilView(viewModel: EditInfoProfilViewModel())
    }
}
