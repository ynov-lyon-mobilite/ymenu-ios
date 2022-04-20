//
//  HistoryView.swift
//  ymenu-ios
//
//  Created by Antoine Mousset on 31/03/2021.
//

import Foundation
import SwiftUI
import Combine
import SDWebImageSwiftUI

struct HistoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: HistoryViewModel
    @State var scrollPosition: CGFloat = 0.0
    var bag = Set<AnyCancellable>()
    @State var historyLoaded = false
    @State var showAlert = false
    
    @ObservedObject var applicationState: ApplicationState = ApplicationState.shared
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            if !self.historyLoaded {
                ProgressView("Chargement de l'historique")
                    .zIndex(1)
            }
            VStack {
                List {
                    ForEach(viewModel.restaurants, id: \.self) { restaurant in
                        HStack {
                            Button(action: {
                                DispatchQueue.main.async {
                                    self.viewRouter.restaurant = RestaurantDTO(_id: restaurant._id, name: restaurant.name)
                                    withAnimation {
                                        self.viewRouter.currentPage = "greetingcard.fill"
                                    }
                                }
                            }){
                                WebImage(url: URL(string: restaurant.url_logo))
                                    .onSuccess { image, data, cacheType in
                                    }
                                    .resizable()
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray)
                                    }
                                    .indicator(.activity)
                                    .transition(.fade(duration: 0.5))
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 95, alignment: .center)
                                    .cornerRadius(13)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .shadow(radius: 6, x: 3, y: 3)
                                    .padding(.leading, -30).padding(.trailing, 10)
                                VStack(alignment: .center){
                                    Text(restaurant.name).bold()

                                    Text(restaurant.address).font(.system(size: 16, weight: .light, design: .rounded)).multilineTextAlignment(.center)
                        
                                }.padding(.leading, 5).padding(.trailing, 5).frame(maxWidth: .infinity, maxHeight: .infinity)
                                .contentShape(Rectangle())
                 
                            }
                        }.padding()
                    }.onAppear{
                        self.historyLoaded = true
                    }
                }
                .navigationBarTitle(Text("Historique"), displayMode: .inline)
            }
            .listStyle(InsetGroupedListStyle())
            .progressViewStyle(CircularProgressViewStyle())
            .onAppear() {
                if self.viewModel.noRestaurants  {
                    self.showAlert = true
                }
            }
            
        }.buttonStyle(PlainButtonStyle()).onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font : UIFont(name:"SF Pro Rounded Bold", size: 40) as Any
            ]
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("Historique vide"),
                message: Text("Votre historique de restaurants scannés est vide, veuillez scanner un QR code afin qu'il apparaisse ici"),
                dismissButton: .cancel(Text("Retourner sur le profil"), action: {
                    DispatchQueue.main.async{
                        withAnimation(.easeOut(duration: 0.2)) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }))
        }
    }
}


//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView(selectedTab: "person.fill")
//    }
//}
