//
//  MenuView.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 16/12/2020.
//

import Foundation
import SwiftUI
import Combine
import SDWebImageSwiftUI

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: MenuViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var scrollPosition: CGFloat = 0.0
    var bag = Set<AnyCancellable>()
    @State var menuLoaded = false
    @State private var showAlert = false

    init(restaurant: RestaurantDTO) {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name:"SF Pro Rounded Bold", size: 40)!
        ]

        self.viewModel = MenuViewModel(restaurant: restaurant)
    }
 
    func tapticFail() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    var body: some View {
        if !self.menuLoaded {
             ProgressView("Chargement du menu")
                 .zIndex(1)
        }
        NavigationView {
            ScrollViewReader { proxy in
                VStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (alignment: VerticalAlignment.center, spacing: 5){
                            IndexedForEach(viewModel.dishCategories) { index, category in
                                Button(action: {
                                    withAnimation {
                                        proxy.scrollTo(category._id, anchor: .top)
                                    }
                                    viewModel.selectedCategoryId = category._id
                                }) {
                                    Text(category.name)
                                        .fontWeight(viewModel.selectedCategory?._id == category._id ? .bold : .regular)
                                        .overlay(viewModel.selectedCategory?._id == category._id ? RoundedRectangle(cornerRadius: .infinity).shadow(color: Color.red, radius: 2.5, x: 0, y: 1).foregroundColor(Color.red).frame(height: 3).offset(y: 5) : nil, alignment: .bottom)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                        .padding(.top, 12)
                                        .padding(.bottom, 12)
                                }
                                Spacer()
                                Divider()
                                Spacer()
                            }.onAppear() {
                                !menuLoaded ? viewModel.selectedCategoryId = viewModel.dishCategories[0]._id : nil
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 20)
                    }
                    
                    List {
                        IndexedForEach(viewModel.dishCategories) { index, category in
                            Section(header: Text(category.name).padding(.leading, 20).padding(.bottom, -10)){
                                ForEach(viewModel.dishes.filter { $0.category_id == category._id }, id: \._id) { dish in
                                        ZStack{
                                            Button("") {}
                                            NavigationLink(destination: DishDetailView(dish: dish)){
                                                ZStack {
                                                    WebImage(url: URL(string: dish.url_logo))
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
                                                        .frame(width: 126, height: 83, alignment: .center)
                                                        .cornerRadius(13)
                                                        .frame(maxWidth: .infinity, alignment: .center)
                                                        .shadow(radius: 6, x: 3, y: 3)
                                                    if (dish.url_model != "") {
                                                        Image(systemName: "arkit")
                                                            .font(.system(size: 16, weight: .light, design: .rounded))
                                                            .padding(5)
                                                            .background(
                                                                Blur(style: .systemUltraThinMaterial)
                                                            ).cornerRadius(13).offset(x: -42, y: -20)
                                                    }
                                                }
                                                
                                                Text(dish.name).multilineTextAlignment(.leading)
                                                    .padding(.leading, 10)
                                                Spacer()
                                                Text("\(String(describing: dish.price))0 €").bold().multilineTextAlignment(.center)
                                                Spacer().frame(width: 5)
                                            }
                                    }
                                }
                            }.id(category._id)
                        }.onAppear() {
                            self.menuLoaded = true
                        }
                        .navigationBarTitle(self.viewModel.restaurant.name, displayMode: .automatic)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .padding(.horizontal, -20).progressViewStyle(CircularProgressViewStyle())
                }.onAppear() {
                    if self.viewModel.restaurant.name == "" {
                        self.showAlert = true
                        tapticFail()
                    }
                }
            }
        }.accentColor( .red).alert(isPresented: $showAlert) {
            Alert(
                title: Text("Aucun restaurant"),
                message: Text("Veuillez scanner un QR Code afin de récupérer le menu du restaurant"),
                dismissButton: .cancel(Text("Ouvrir le scanneur"), action: {
                    DispatchQueue.main.async{
                        withAnimation(.easeOut(duration: 0.2)) {
                            self.viewRouter.currentPage = "qrcode.viewfinder"
                        }
                    }
                }))
        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(restaurant: RestaurantDTO(_id: "6007fabd63c8d10017d2b3ba", name: "Minute Asia"), selectedTab: "greetingcard.fill")
//
//    }
//}
