//
//  RegisterView.swift
//
//  Created by Antoine Mousset on 18/04/2021
//
import SwiftUI

struct RegisterView: View {
    // MARK: - Propertiers
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

                VStack(alignment: .leading, spacing: 15) {
                    TextField("Nom", text: $viewModel.firstname)
                        .padding()
                        .cornerRadius(20.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                    
                    TextField("Prenom", text: $viewModel.lastname)
                        .padding()
                        .cornerRadius(20.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                    
                    TextField("Email", text: $viewModel.mail)
                        .padding()
                        .cornerRadius(20.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Mot de passe", text: $viewModel.password)
                        .padding()
                        .cornerRadius(20.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
                    
                    SecureField("Confirmer le mot de passe", text: $viewModel.confirmpassword)
                        .padding()
                        .cornerRadius(20.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.themeTextField, lineWidth: 2)
                        )
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
                .cornerRadius(.greatestFiniteMagnitude)
                .shadow(radius: 6, x: 3, y: 3)
                .padding(.top, 20)
                .padding([.trailing, .leading], 100)
                .disabled(viewModel.isLoading)
                
                Spacer()
                HStack(spacing: 0) {
                    Text("Déjà un compte?")
                    Button(action: {
                        self.dismissRegister.toggle()
                    })
                    {
                        Text("Se connecter")
                            .bold()
                            .padding(.leading, 10)
                            .foregroundColor(Color.themeTextField)
                    }
                }.padding(.bottom, 30)
                .navigationBarItems(leading:
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
        }.alert(isPresented: $showAlert) {
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
        
    }
}


