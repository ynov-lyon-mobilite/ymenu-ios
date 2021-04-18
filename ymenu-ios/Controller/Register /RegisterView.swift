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
    @State private var emptyFields: Bool = false
    @Binding var showRegister: Bool
    @ObservedObject var viewModel: RegisterViewModel

    // MARK: - View
    var disableForm: Bool {
        password.count < 5 || confirmpassword.count < 5
    }
    var body: some View {
        NavigationView {
            VStack {
                Image("logoymenu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120, alignment: .center)
                    .padding(25)
                    .background(RoundedRectangle(cornerRadius: 35).foregroundColor(.white))
                    .padding(.bottom, 20)
                    .padding(.top, -50)
                
                Text("Inscrivez-vous")
                    .font(.custom("SF Pro Rounded Bold", fixedSize: 24))
                
                Text("Gardez un historique des restaurants visités")
                    .font(.custom("SF Pro Text Regular", fixedSize: 16))
                    .lineLimit(2)
                    .padding([.top, .bottom], 20)
                
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Nom", text: $viewModel.firstname)
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 6, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                     
                    TextField("Prenom", text: $viewModel.lastname)
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 6, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                    
                    TextField("Email", text: $viewModel.mail)
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 6, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Mot de passe", text: $viewModel.password)
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 6, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                    
                    SecureField("Confirmer le mot de passe", text: $viewModel.confirmpassword)
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 6, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                }.padding([.leading, .trailing], 27.5)
                    Button(action: {
                        viewModel.wrongCredentials = false
                        emptyFields = false
                        if(viewModel.mail.isEmpty || viewModel.password.isEmpty || viewModel.firstname.isEmpty || viewModel.lastname.isEmpty || viewModel.confirmpassword.isEmpty || password != confirmpassword) {
                            withAnimation {
                                emptyFields = true
                            }
                        } else {
                            viewModel.isLoading.toggle()
                            viewModel.handleRegister()
                            hideKeyboard()
                        }
                    }) {
                        HStack {
                                if viewModel.isLoading {
                                    ProgressView().padding(.horizontal, 3).progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                                    Text("Chargement...")
                                        .bold()
                                } else {
                            Text("S'inscrire")
                                .bold()
                            }
                        }}.padding()
                    .foregroundColor(.white)
                    .padding([.trailing, .leading], 50)
                    .background(Color.themeTextField)
                    .cornerRadius(.greatestFiniteMagnitude)
                    .shadow(radius: 6, x: 3, y: 3)
//                    .disabled(disableForm)
               
                Spacer()
                HStack(spacing: 0) {
                    Text("Déjà un compte?")
                    Button(action: {
                        self.showRegister.toggle()
                    })
                    {
                        Text("Se connecter")
                            .bold()
                            .padding(.leading, 10)
                            .foregroundColor(Color.themeTextField)
                    }
                }.padding(.bottom, 30).navigationBarItems(leading:
                    Button(action: {
                        self.showRegister.toggle()
                    }) {
                        Text("Retour").accentColor(Color.themeTextField)
                    }
                )
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(showRegister: .constant(true), viewModel: RegisterViewModel())
        
    }
}


