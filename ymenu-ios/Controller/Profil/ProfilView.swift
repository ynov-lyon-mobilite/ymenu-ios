//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI

struct ProfilView: View {
    @State var isPresented = false
    @ObservedObject var applicationState: ApplicationState = ApplicationState.shared
    @State var showAlert = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.1))
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Image("logoymenu")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120, alignment: .center)
                        .padding(25)
                        .background(RoundedRectangle(cornerRadius: 35).foregroundColor(.white))
                        .offset( y: -230)
                }
                VStack{
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40, alignment: .center)
                        .padding(.top)
                        .padding(.bottom)
                        .offset(y: -320)
                        .offset(x: 160)
                }
                VStack{
                    Text("Profil")
                        .font(.custom("SF Pro Text Regular", size: 30))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                        .offset(y: -90)
                }
                VStack{
                    NavigationLink(
                        destination: InfoProfilView()) {
                        Text("Mes informations")
                            .frame(width: 270, height: 25)
                            .font(.custom("SF Pro Text Regular", size: 22))
                            .padding()
                            .foregroundColor(.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.themeTextField , lineWidth: 2)
                            )
                    }.offset(y: 25)
                }
                VStack{
                    
                    NavigationLink(
                        destination: HistoryView(viewModel: HistoryViewModel())) {
                        Text("Historique de visite")
                            .frame(width: 270, height: 25)
                            .font(.custom("SF Pro Text Regular", size: 22))
                            .padding()
                            .foregroundColor(.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.themeTextField , lineWidth: 2)
                            )
                    }.offset(y: 125)
                }
                VStack{
                    Button(action: {
                        self.showAlert = true
                    }) {
                        HStack {
                            Text("Déconnexion")
                                .bold()
                        }}.padding()
                    .foregroundColor(.white)
                    .padding([.trailing, .leading], 50)
                    .background(Color.themeTextField)
                    .cornerRadius(.greatestFiniteMagnitude)
                    .shadow(radius: 6, x: 3, y: 3)
                    .padding(.top, 40)
                    .offset( y: 205)
                }
                .navigationBarTitle("Profil")// retour (back -> profil)
                .navigationBarHidden(true)
            }.edgesIgnoringSafeArea(.all)
        }.accentColor(Color.themeTextField)// color (profil)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Déconnexion"),
             message: Text("Êtes-vous sûr(e) de vouloir vous déconnecter?"),
             primaryButton: .cancel(Text("Annuler")),
             secondaryButton: .destructive(Text("Se déconnecter"), action: {
                withAnimation {
                    applicationState.disconnect()
                }
             }))
        }
    }
}
struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
