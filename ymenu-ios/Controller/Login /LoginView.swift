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
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120, alignment: .center)
                    .padding(25)
                    .background(RoundedRectangle(cornerRadius: 35).foregroundColor(.white))
                    .padding(.bottom, 40)
                
                Text("Connectez-vous")
                    .font(.custom("SF Pro Text Bold", fixedSize: 22))
                    .padding([.top, .bottom], 20)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: self.$email)
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 6, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                    
                    SecureField("Mot de passe", text: self.$password)
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 6, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                }.padding([.leading, .trailing], 27.5)
                
                Button(action: {
                    
                    
                }) {
                HStack {
//                    if viewModel.isLoading {
//                        ProgressView().padding(.horizontal, 3).progressViewStyle(CircularProgressViewStyle(tint: Color.white))
//                        Text("Chargement...")
//                            .bold()
//                    } else {
                        Image(systemName: "key.fill")
                        Text("Connexion")
                            .bold()
//                    }
                }}.padding()
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(.greatestFiniteMagnitude)
                .shadow(radius: 6, x: 3, y: 3)
                .padding(.top, 40)
                Spacer()
                HStack(spacing: 0) {
                    Text("Pas de compte?")
                    NavigationLink(destination: RegisterView())
                    {
                        Text("S'inscrire")
                            .bold()
                            .padding(.leading, 20)
                            .foregroundColor(.orange)
                    }
                }.padding(.bottom, 30)
            }
            
        }
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 255.0/255.0, green: 188.0/255.0, blue: 102.0/255.0, opacity: 1.0)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.light)
            
    }
}

