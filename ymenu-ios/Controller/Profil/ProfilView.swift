//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isPresented = false
    @ObservedObject var applicationState: ApplicationState = ApplicationState.shared
    @State var showAlert = false

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name:"SF Pro Rounded Bold", size: 40)!
        ]
    }
    var body: some View {
        NavigationView{
            VStack(spacing : 0){
                HStack{
                    Image(systemName:"person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .padding(20)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    VStack (alignment: .leading){
                        HStack {
                            Text((UserDefaults.standard.string(forKey: "firstname") ?? "") + " " + (UserDefaults.standard.string(forKey: "lastname") ?? ""))
                                .bold()
                                .font(.custom("SF Pro Rounded Bold", fixedSize: 18))
                        }
                        
                        Text(UserDefaults.standard.string(forKey: "mail") ?? "").font(.headline)
                    }
                    Spacer()
                }.padding(.bottom, 100)
                VStack {
                    
                    NavigationLink(
                        destination: InfoProfilView()) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.themeTextField)
                                .padding(.horizontal, 10)
                            Text("Mes informations")
                                .font(.headline).bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                            
                    }
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
                    Divider()
                    NavigationLink(
                        destination: HistoryView(viewModel: HistoryViewModel())) {
                            Image(systemName: "clock.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.themeTextField)
                                .padding(.horizontal, 10)
                            Text("Historique de visite")
                                .font(.headline).bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                            
                    }
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
                    Divider()
                    Spacer()
                    Button(action: {
                                self.showAlert = true
                    }) {
                                HStack {
                                    Text("Déconnexion")
                                        .bold()
                                }.frame(maxWidth:.infinity)
                            }.padding()
                            .foregroundColor(.white)
                            .background(Color.themeTextField)
                            .cornerRadius(7)
                            .shadow(radius: 6, x: 3, y: 3)
                            .padding(50)
                }
            }
            .navigationBarTitle(Text("Mon profil"), displayMode: .automatic)
        }.accentColor(Color.themeTextField)
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

