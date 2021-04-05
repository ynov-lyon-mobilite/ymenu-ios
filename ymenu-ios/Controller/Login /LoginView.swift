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
    @State private var showRegister = false
    @ObservedObject var viewModel: LoginViewModel
    @State private var emptyFields: Bool = false
    
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
                
                Text("Connectez-vous")
                    .font(.custom("SF Pro Rounded Bold", fixedSize: 24))
                    .padding([.top, .bottom], 20)
                
                if emptyFields {
                    Text("Un ou plusieurs champs sont vides").foregroundColor(.red).bold().padding(.bottom, 10)
                }
                if viewModel.wrongCredentials {
                    Text("Mauvais mot de passe ou adresse mail").foregroundColor(.red).bold().padding(.bottom, 10)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: $viewModel.mail)
                        .padding()
                        .cornerRadius(20.0)
//                        .shadow(radius: 6, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .onChange(of: viewModel.mail, perform: { value in
                            viewModel.wrongCredentials = false
                            emptyFields = false
                        })
                    
                    SecureField("Mot de passe", text: $viewModel.password)
                        .padding()
                        .onChange(of: viewModel.password, perform: { value in
                            viewModel.wrongCredentials = false
                            emptyFields = false
                        })
                        .cornerRadius(20.0)
//                        .shadow(radius: 6, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                        
                }.padding([.leading, .trailing], 27.5)
                
                Button(action: {
                    
                    viewModel.wrongCredentials = false
                    emptyFields = false
                    if(viewModel.mail.isEmpty || viewModel.password.isEmpty) {
                        withAnimation {
                            emptyFields = true
                        }
                    } else {
                        viewModel.isLoading.toggle()
                        viewModel.handleLogin()
                        hideKeyboard()
                    }
                }) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView().padding(.horizontal, 3).progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            Text("Chargement...")
                                .bold()
                        } else {
                            Text("Connexion")
                                .bold()
                        }
                    }.frame(maxWidth:.infinity)
                }.disabled(viewModel.isLoading)
                .padding()
                .foregroundColor(.white)
                .background(Color.themeTextField)
                .cornerRadius(.greatestFiniteMagnitude)
                .shadow(radius: 6, x: 3, y: 3)
                .padding(.top, 40)
                .padding([.trailing, .leading], 100)
                Spacer()
                HStack(spacing: 0) {
                    Text("Pas de compte?")
                    Button(action: {
                        showRegister.toggle()
                    })
                    {
                        Text("S'inscrire")
                            .bold()
                            .padding(.leading, 10)
                            .foregroundColor(Color.themeTextField)
                    }.sheet(isPresented: $showRegister){
                        RegisterView(showRegister: $showRegister)
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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
            .preferredColorScheme(.light)
        
    }
}

