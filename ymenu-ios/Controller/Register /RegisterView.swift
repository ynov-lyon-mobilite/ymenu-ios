//
//  RegisterView.swift
//
//  Created by Antoine Mousset on 18/04/2021
//

import Foundation
import SwiftUI

struct RegisterView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: RegisterViewModel
    @State private var unvalidPassword: Bool = false
    @State private var emptyFields: Bool = false
    @State private var unmatchedPasswords: Bool = false
    @State private var unvalidMail: Bool = false
    @State var showAlert = false
    @Binding var dismissRegister: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                if viewModel.error {
                    Text("Une erreur est servenue").foregroundColor(.red).bold().padding(.bottom, 10)
                } else if emptyFields {
                    Text("Un ou plusieurs champs sont vides").foregroundColor(.red).bold().padding(.bottom, 10)
                } else if viewModel.accountExist {
                    Text("Un compte existe déjà pour cette adresse mail").foregroundColor(.red).bold().padding(.bottom, 10)
                } else if unvalidPassword {
                    Text("Le mot de passe doit être d'au moins 6 caractères").foregroundColor(.red).bold().padding(.bottom, 10)
                } else if unmatchedPasswords {
                    Text("Les mots de passe de correspondent pas").foregroundColor(.red).bold().padding(.bottom, 10)
                } else if unvalidMail {
                    Text("Veuillez entrer une adresse mail valide").foregroundColor(.red).bold().padding(.bottom, 10)
                }

                VStack(alignment: .leading, spacing: 20){
                    VStack(alignment: .leading){
                        Text("Gardez un historique de vos meilleurs moments!").font(.subheadline).padding(.leading, -10)
                        Text("Nom").fontWeight(.bold).padding(.top, 20)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            TextField("Votre nom", text: $viewModel.lastname)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(8)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Prénom").fontWeight(.bold)
                        HStack{
                            Image (systemName: "person.crop.circle").opacity((0.5))
                            
                            TextField("Votre prénom", text: $viewModel.firstname)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(8)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Adresse mail").fontWeight(.bold)
                        HStack{
                            Image (systemName: "envelope").opacity((0.5))
                            
                            TextField("Votre adresse mail", text: $viewModel.mail)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(8)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Mot de passe").fontWeight(.bold)
                        HStack{
                            Image (systemName: "lock.fill").opacity((0.5))
                            
                            SecureField("Votre mot de passe", text: $viewModel.password)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(8)
                        }
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Confirmez le mot de passe").fontWeight(.bold)
                        HStack{
                            Image (systemName: "lock.fill").opacity((0.5))
                            
                            SecureField("Confirmez votre mot de passe", text: $viewModel.confirmpassword)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(8)
                        }
                        Divider()
                    }
                }.padding([.leading, .trailing], 27.5)
                .onChange(of: [viewModel.firstname, viewModel.lastname, viewModel.mail, viewModel.password, viewModel.confirmpassword], perform: { value in
                    viewModel.error = false
                    viewModel.accountExist = false
                    unvalidPassword = false
                    unvalidMail = false
                    emptyFields = false
                    unmatchedPasswords = false
                })
                Button(action: {
                    viewModel.error = false
                    viewModel.accountExist = false
                    unvalidPassword = false
                    unvalidMail = false
                    emptyFields = false
                    unmatchedPasswords = false
                    if(viewModel.mail.isEmpty || viewModel.password.isEmpty || viewModel.firstname.isEmpty || viewModel.lastname.isEmpty || viewModel.confirmpassword.isEmpty) {
                        withAnimation {
                            emptyFields = true
                        }
                    }
                    else if (viewModel.mail.range(of: #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#,
                    options: .regularExpression) == nil) {
                        withAnimation{
                            unvalidMail = true
                        }
                    }
                    else if(viewModel.password.count < 6) {
                        withAnimation {
                            unvalidPassword = true
                        }
                    }
                    else if(viewModel.password != viewModel.confirmpassword) {
                        withAnimation {
                            unmatchedPasswords = true
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
                    }.frame(maxWidth:.infinity)
                }.padding()
                .foregroundColor(.white)
                .background(Color.themeTextField)
                .cornerRadius(10)
                .shadow(radius: 6, x: 3, y: 3)
                .padding(.top, 20)
                .padding([.trailing, .leading])
                .disabled(viewModel.isLoading)
                
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    Text("Vous avez déjà un compte ?")
                    Button(action: {
                        self.dismissRegister.toggle()
                    })
                    {
                        Text("Se connecter")
                            .bold()
                            .padding(.leading, 10)
                            .foregroundColor(Color.themeTextField)
                    }
                    Spacer()
                }.padding(.bottom, 30).padding(.top, 10)
                .navigationBarTitle("Inscription")
                .navigationBarItems(
                    leading:
                        Button(action: {
                            self.dismissRegister.toggle()
                        }) {
                            Text("Retour").accentColor(Color.themeTextField)
                        }
                )
            }.onReceive(viewModel.viewDismissalModePublisher) { shouldDismiss in
                DispatchQueue.main.async{
                    if shouldDismiss {
                        self.showAlert = true
                    }

                }
            }
        }.onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font : UIFont(name:"SF Pro Rounded Bold", size: 40) as Any
            ]
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Compte créé"),
                message: Text("Votre compte a été créé avec succès, connectez-vous dès maintenant pour y accéder"),
                dismissButton: .cancel(Text("OK"), action: {
                    DispatchQueue.main.async{
                        withAnimation(.easeOut(duration: 0.2)) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }))
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel(), dismissRegister: .constant(true))
            .previewDevice("iPhone SE (3rd generation)")
        
    }
}


