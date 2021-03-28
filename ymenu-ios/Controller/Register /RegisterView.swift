//
//  ContentView.swift
//  LoginScreenTutorial
//
//  Created by Antoine Mousset on Today.
//
import SwiftUI

struct RegisterView: View {
    // MARK: - Propertiers
    @State private var email = ""
    @State private var password = ""
    @State private var confirmpassword = ""
    @State private var nom = ""
    @State private var prenom = ""
    // MARK: - View
    var disableForm: Bool {
        password.count < 5 || confirmpassword.count < 5
    }
    var body: some View {
        VStack() {
            Image("logoymenu")
                .resizable()
                .frame(width: 154, height: 155)
                .padding(.bottom, 20)
            
            Text("Inscrivez-vous")
                .font(.custom("SF Pro Text Regular", fixedSize: 25))
                .font(.title).foregroundColor(Color.black)
                .padding([.top, .bottom], 10)
            
            Text("Accédez à votre historique de restaurants visités")
                .font(.custom("SF Pro Text Regular", fixedSize: 16))
                .lineLimit(2)
                .padding([.top, .bottom], 20)

            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: self.$email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 6, x: 3, y: 3)
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.themeTextField, lineWidth: 2)
                            )
                
                SecureField("Mot de passe", text: self.$password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 6, x: 3, y: 3)
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.themeTextField, lineWidth: 2)
                            )
         
            SecureField("Confirmer le mot de passe", text: self.$confirmpassword)
                .padding()
                .background(Color.white)
                .cornerRadius(20.0)
                .shadow(radius: 6, x: 3, y: 3)
                .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                
                SecureField("Nom", text: self.$nom)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 6, x: 3, y: 3)
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.themeTextField, lineWidth: 2)
                            )
       
            
        SecureField("Prenom", text: self.$prenom)
            .padding()
            .background(Color.white)
            .cornerRadius(20.0)
            .shadow(radius: 6, x: 3, y: 3)
            .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.themeTextField, lineWidth: 2)
                    )
    }.padding([.leading, .trailing], 27.5)
            
            if password == confirmpassword{
            Button("") {}
        NavigationLink(destination: Home()) {
                Text("S'inscrire")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.themeTextField)
                    .cornerRadius(15.0)
                    .shadow(radius: 6, x: 3, y: 3)
            }.padding(.top, 50)
             .disabled(disableForm)

            }
            else {
                
            }
            
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}




