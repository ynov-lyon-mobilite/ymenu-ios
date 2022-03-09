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
    @State private var dismissRegister = false
    @ObservedObject var viewModel: LoginViewModel
    @State private var emptyFields: Bool = false
    
    
    // MARK: - View
    var body: some View {
        NavigationView {
            VStack() {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170, height: 170, alignment: .center)
                    .padding(25)
                    .background(RoundedRectangle(cornerRadius: 35).foregroundColor(.white))
                
//                Text("Connectez-vous")
//                    .font(.custom("SF Pro Rounded Bold", fixedSize: 24))
//                    .padding([.top, .bottom], 20)
                
                if emptyFields {
                    Text("Un ou plusieurs champs sont vides").foregroundColor(.red).bold().padding(.bottom, 10)
                }
                if viewModel.wrongCredentials {
                    Text("Mauvais mot de passe ou adresse mail").foregroundColor(.red).bold().padding(.bottom, 10)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading){
                        Text("Nom d'utilisateur").fontWeight(.bold)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            TextField("Ton nom d'utilisateur", text: $viewModel.mail)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Mot de passe").fontWeight(.bold)
                        HStack{
                            Image (systemName: "lock.fill").opacity((0.5))
                            TextField("Ton mot de passe", text: $viewModel.password)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Button(action: {
                            
                        }) {
                            Text("Mot de passe oublié ?").foregroundColor(Color.gray.opacity((0.5)))
                        }
                    }
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
                .cornerRadius(10)
                .shadow(radius: 6, x: 3, y: 3)
                .padding(.top, 40)
                .padding([.trailing, .leading])
                Spacer()
                HStack(spacing: 0) {
                    Text("Pas de compte?")
                    Button(action: {
                        dismissRegister.toggle()
                    })
                    {
                        Text("S'inscrire")
                            .bold()
                            .padding(.leading, 10)
                            .foregroundColor(Color.themeTextField)
                    }.sheet(isPresented: $dismissRegister){
                        RegisterView(viewModel: RegisterViewModel(), dismissRegister: $dismissRegister)
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
