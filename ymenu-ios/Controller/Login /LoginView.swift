//
//  ContentView.swift
//  LoginScreenTutorial
//
//  Created by Antoine Mousset on Today.
//
//
import SwiftUI

struct LoginView: View {
    // MARK: - Propertiers
    @State private var email = ""
    @State private var password = ""
    
    // MARK: - View
    var body: some View {
        NavigationView {
        VStack() {
            Image("logoymenu")
                .resizable()
                .frame(width: 154, height: 155)
                .padding(.bottom, 20)
            
            Text("Connectez-vous")
                .font(.largeTitle).foregroundColor(Color.black)
                .padding([.top, .bottom], 20)
                .shadow(radius: 10.0, x: 20, y: 10)
            
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
            }.padding([.leading, .trailing], 27.5)
            
            Button("") {}
            NavigationLink(destination: Home()) {
                Text("Se connecter")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.orange)
                    .cornerRadius(15.0)
                    .shadow(radius: 6, x: 3, y: 3)
            }.padding(.top, 50)
            
            Spacer()
            HStack(spacing: 0) {
                Text("Pas de compte?")
                NavigationLink(destination: RegisterView())
                {
                    Text(" S'inscrire")
                        .foregroundColor(.orange)
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        
    }
}
}
extension Color {
    static var themeTextField: Color {
        return Color(red: 255.0/255.0, green: 188.0/255.0, blue: 102.0/255.0, opacity: 1.0)
    }
}

