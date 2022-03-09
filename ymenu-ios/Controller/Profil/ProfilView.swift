//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

final class ViewModel: ObservableObject {
    @Published
    var profilCategorieNames: [String:String] =
    ["Mes informations":"person.crop.circle.fill", "Historiques de visite":"menucard.fill", "Donner un avis":"bubble.left.circle.fill", "Informations légales":"info.circle.fill", "Language":"graduationcap.fill"]
}
struct ProfilView: View {
    @State var isPresented = false
    @ObservedObject var applicationState: ApplicationState = ApplicationState.shared
    @ObservedObject var viewModel = ViewModel()
    @State var showAlert = false

    init(){
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
                        .padding(.leading, 20)
                    VStack{
                    Text("Stéphanie Burdin")
                            .padding(.leading, 20)
                            .font(.custom("SF Pro Text Regular", fixedSize: 18))
                    Text("+336 07 07 74 08")
                    }
                    Spacer()
                }.padding(.bottom, 100)
                ForEach(viewModel.profilCategorieNames.keys.sorted(), id : \.self) { key in
                    HStack {
                        Image(systemName: self.viewModel.profilCategorieNames[key]!).foregroundColor(Color.orange)
                    Text(key)
                            .font(.body)
                    Spacer()
                    Image(systemName: "chevron.right")
                    .foregroundColor(Color(.systemGray3))
                }
                    .padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
                    Divider()
                }
                VStack{
                    Text("Déconnexion")
                        .font(.custom("SF Pro Text Regular", fixedSize: 17))
                        .foregroundColor(.white)
                        .frame(width: 220, height: 60)
                        .background(Color.orange)
                        .cornerRadius(10)
                        
                }.padding(50)
            }
            .navigationBarTitle(Text("Mon Profil"), displayMode: .automatic)
        }
    }
}
struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
        }
    }

