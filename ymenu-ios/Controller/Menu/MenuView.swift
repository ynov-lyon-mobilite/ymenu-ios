//
//  MenuView.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 16/12/2020.
//

import Foundation
import SwiftUI

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: MenuViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    @Namespace var animation
    @State var currentTab = ""
    @State var onTapCurrentTab: String = ""
    @State var menuLoaded = false
    @State private var showAlert = false
    @State private var presentRestaurant = false

    init(restaurant: RestaurantDTO) {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name:"SF Pro Rounded Bold", size: 40)!
        ]
        
        viewModel = .init(restaurant: restaurant)
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
            VStack(spacing: 0) {
                VStack(alignment: .leading){
//                    Text("restaurant address")
//                        .font(.subheadline).padding(.leading, 20).foregroundColor(.gray)
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20){

                                IndexedForEach(viewModel.dishCategories) { index, category in
                                    VStack{
                                        Text(category.name)
                                            .fontWeight(currentTab == category.name ? .bold : .regular)
                                            .foregroundColor(currentTab == category.name ? ((colorScheme == .light) ? .black : .white) : .gray)
                                            .animation(.none, value: currentTab)

                                        if currentTab == category.name {

                                            Capsule()
                                                .fill(Color.themeTextField)
                                                .matchedGeometryEffect(id: "TAB", in: animation)
                                                .frame(height: 3)
                                                .padding(.horizontal,-10)
                                        }
                                        else{
                                            Capsule()
                                                .fill(.clear)
                                                .frame(height: 3)
                                                .padding(.horizontal,-10)
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {

                                        if onTapCurrentTab == category.name {return}

                                        withAnimation(.easeInOut){
                                            onTapCurrentTab = category.name
                                            proxy.scrollTo(category.name, anchor: .topTrailing)
                                         }
                                    }
                                }
                            }
                            .padding(.horizontal,30)
                            .onChange(of: currentTab) { _ in
                                withAnimation{
                                    proxy.scrollTo(currentTab, anchor: .topTrailing)
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .onAppear() {
                        if self.viewModel.restaurant.name == "" {
                            self.showAlert = true
                            tapticFail()
                        }
                    }
                }
                .onAppear() {
                    self.menuLoaded = true
                }
                .navigationBarTitle(self.viewModel.restaurant.name, displayMode: .automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if (self.viewModel.restaurant.name != "") {
                            Button(action: {
                                self.presentRestaurant.toggle()
                            })
                            {
                                Image(systemName: "info.circle").foregroundColor(Color.themeTextField)
                            }
                        }
                    }
                }
                .overlay(
                    Divider()
                        .padding(.horizontal,-15)
                    ,alignment: .bottom
                )

                ScrollView(.vertical, showsIndicators: false){
                    ScrollViewReader{proxy in
                        VStack(spacing: 15){
                            IndexedForEach(viewModel.dishCategories){ index, category  in
                                MenuCardView(dishCategory: category, dishes: viewModel.dishes, currentTab: $currentTab)
                                    .padding(.top)
                                }
                        }
                        .padding([.horizontal,.bottom])
                        .onChange(of: onTapCurrentTab) { newValue in
                            withAnimation(.easeInOut){
                                proxy.scrollTo(onTapCurrentTab, anchor: .topTrailing)
                            }
                        }
                    }
                }
                .coordinateSpace(name: "SCROLL")
            }
            .onAppear {
                currentTab = viewModel.dishCategories.first?.name ?? ""
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .accentColor( .red).alert(isPresented: $showAlert) {
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
        .sheet(isPresented: $presentRestaurant){
            RestaurantInfoView(viewModel: RestaurantInfoViewModel(), presentRestaurant: $presentRestaurant, restaurantDTO: viewModel.restaurant)
        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(restaurant: RestaurantDTO(_id: "6007fabd63c8d10017d2b3ba", name: "Minute Asia"))
//
//    }
//}
