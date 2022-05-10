//
//  ContentView.swift
//  LoginScreenTutorial
//
//  Created by Antoine Mousset on Today.
//
//
import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties

    @State private var presentRegister = false
    @ObservedObject var viewModel: LoginViewModel
    @State private var emptyFields: Bool = false

    // MARK: - View
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding(10)
                
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
                    VStack(alignment: .leading){
                        Text("Adresse mail").fontWeight(.bold)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            TextField("Votre adresse mail", text: $viewModel.mail)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(10)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Mot de passe").fontWeight(.bold)
                        HStack{
                            Image (systemName: "lock.fill").opacity((0.5))
                            SecureField("Votre mot de passe", text: $viewModel.password)
                                .padding(10)
                        }
                        Divider()
                    
//                    TODO: Forgot password
//                    VStack(alignment: .leading){
//                        Button(action: {
//
//                        }) {
//                            Text("Mot de passe oublié ?").foregroundColor(Color.gray.opacity((0.5)))
//                        }
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
                .cornerRadius(7)
                .shadow(radius: 6, x: 3, y: 3)
                .padding(.horizontal, 50)
                .padding(.top, 20)
                Spacer()
                HStack(spacing: 0) {
                    Text("Pas encore de compte?")
                    Button(action: {
                        presentRegister.toggle()
                    })
                    {
                        Text("S'inscrire")
                            .bold()
                            .padding(.leading, 10)
                            .foregroundColor(Color.themeTextField)
                    }.sheet(isPresented: $presentRegister){
                        RegisterView(viewModel: RegisterViewModel(), presentRegister: $presentRegister)
                    }
                }.padding(.vertical, 20)
                
            }
        }
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 245.0/255.0, green: 160.0/255.0, blue: 105.0/255.0, opacity: 1.0)
    }
    static var themeTextFieldAlt: Color {
      return Color(red: 242.0/255.0, green: 130.0/255.0, blue: 58.0/255.0, opacity: 1.0)
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
            .preferredColorScheme(.dark)
    }
}
