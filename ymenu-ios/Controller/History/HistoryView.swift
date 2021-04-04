////
////  HistoryView.swift
////  ymenu-ios
////
////  Created by Antoine Mousset on 31/03/2021.
////
//
//import SwiftUI
//import SDWebImageSwiftUI
//
//struct HistoryView: View {
////    @Environment(\.colorScheme) var colorScheme
//    @ObservedObject var viewModel: HistoryViewModel
////    @State var scrollPosition: CGFloat = 0.0
////    var bag = Set<AnyCancellable>()
////    @State var menuLoaded = false
////    @State private var showAlert = false
////    var selectedTab: Binding<String>
//
//    init(restaurant: RestaurantDTO, selectedTab: Binding<String>) {
//        UINavigationBar.appearance().largeTitleTextAttributes = [
//            .font : UIFont(name:"SF Pro Rounded Bold", size: 40)!
//        ]
////
////        self.selectedTab = selectedTab
//        self.viewModel = HistoryViewModel()
//    }
//
//    func tapticFail() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.error)
//    }
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Antoine Mousset")
//            Text("a@m.com")
//                            VStack {
//                                WebImage(url: URL(string: Restaurant.url_logo))
//                                                         .onSuccess { image, data, cacheType in
//                                                         }
//                                                         .resizable()
//                                                         .placeholder {
//                                                             Circle().foregroundColor(.gray)
//                                                         }
//                                                         .indicator(.activity)
//                                                         .transition(.fade(duration: 0.5))
//                                                           .overlay(Circle().stroke(Color.white))
//                                                         .scaledToFit()
//                                                           .aspectRatio(contentMode: .fill)
//                                                           .frame(width:30, height: 28, alignment: .topTrailing)
//                                                           .cornerRadius(1000)
//                                                           .shadow(radius: 6, x: 3, y: 3)
//                                Spacer()
//                                Spacer()
//                                Spacer()
//                                Image("logoymenu")
//                                               .resizable()
//                                               .frame(width: 154, height: 155)
//                                               .padding(.bottom, 20)
//                                Spacer()
//
//                                Text("Historique de visite")
//                                .padding(.top, 10)
//                                .padding(.bottom, 10)
//                                .font(.custom("SF Pro Text Bold", fixedSize: 22))
//                                Spacer()
//                            List {
//                                Button("") {}
//                                NavigationLink(destination: EmptyView()){
//                                    ZStack {
//                                WebImage(url: URL(string: "https://image.freepik.com/vecteurs-libre/restaurant-logo-modele_1236-155.jpg"))
//                                  .onSuccess { image, data, cacheType in
//                                  }
//                                  .resizable()
//                                  .placeholder {
//                                    Rectangle().foregroundColor(.gray)
//                                  }
//                                  .indicator(.activity)
//                                  .transition(.fade(duration: 0.5))
//                                  .scaledToFit()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 126, height: 83, alignment: .center)
//                                    .cornerRadius(13)
//                                    .frame(maxWidth: .infinity, alignment: .center)
//                                    .shadow(radius: 6, x: 3, y: 3)
//
//                            }
//
//                            Text("Minute Asia").multilineTextAlignment(.leading)
//                                .padding(.leading, 10)
//                            Spacer()
//                        }
//
//
//                            }
//                            }
//                            }
//        }
//    }



//
//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView(restaurant: restaurant)
//    }
//}



import Foundation
import SwiftUI
import Combine
import SDWebImageSwiftUI

struct HistoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: HistoryViewModel
    @State var scrollPosition: CGFloat = 0.0
    var bag = Set<AnyCancellable>()
    @State var menuLoaded = false
    @State private var showAlert = false
    var selectedTab: Binding<String>

    init(selectedTab: Binding<String>) {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name:"SF Pro Rounded Bold", size: 40)!
        ]

        self.selectedTab = selectedTab
        self.viewModel = HistoryViewModel()
    }
 
    func tapticFail() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    var body: some View {
//        if !self.menuLoaded {
//             ProgressView("Chargement du menu")
//                 .zIndex(1)
//        }
        NavigationView {
            ScrollViewReader { proxy in
                VStack{
                    List {
                        ForEach(viewModel.restaurants, id: \.self) { restaurant in
                                        ZStack{
                                            Button("") {}
                                            NavigationLink(destination: EmptyView()){
                                                ZStack {
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
                                                        .frame(width: 126, height: 83, alignment: .center)
                                                        .cornerRadius(13)
                                                        .frame(maxWidth: .infinity, alignment: .center)
                                                        .shadow(radius: 6, x: 3, y: 3)
                                                }
                                                
                                                Text(restaurant.name).multilineTextAlignment(.leading)
                                                    .padding(.leading, 10)
                                                Spacer()
//                                                Text("\(String(describing: dish.price))0 €").bold().multilineTextAlignment(.center)
                                                Spacer().frame(width: 5)
                                            }
                                    }
                                }
                        }
                        .navigationBarTitle("Historique", displayMode: .automatic)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .padding(.horizontal, -20).progressViewStyle(CircularProgressViewStyle())
                }
            }.accentColor( .red)
        }
    }


//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(restaurant: RestaurantDTO(_id: "6007fabd63c8d10017d2b3ba", name: "Minute Asia"), selectedTab: "greetingcard.fill")
//
//    }
//}
