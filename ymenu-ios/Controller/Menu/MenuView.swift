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
    @State var currentTab = ""
    @State var onTapCurrentTab: String = ""
    var bag = Set<AnyCancellable>()
    @State var menuLoaded = false
    @State private var showAlert = false
    @Namespace var animation


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
                    
                VStack {
                
                    ScrollViewReader{proxy in

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 20){

                                IndexedForEach(viewModel.dishCategories) { index, category in

                                    VStack{

                                        Text(category.name)
                                            .fontWeight(currentTab == category.name ? .bold : .regular)
                                            .foregroundColor(currentTab == category.name ? ((colorScheme == .light) ? .black : .white) : .gray)
                                            .animation(.none, value: currentTab)

                                        // For matched geometry effect...
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
                .padding(.top, 20)
                .padding(.bottom, 20)
                .padding([.top])
        //             Divider...
                .background(colorScheme == .dark ? Color.black : Color.white)
                .overlay(
                    Divider()
                        .padding(.horizontal,-15)

                    ,alignment: .bottom
                )
                
                
                ScrollView(.vertical,showsIndicators: false){
                    
                    // Scroll view reader to scroll the content...
                    ScrollViewReader{proxy in
                        
                        VStack(spacing: 15){
                            
                            IndexedForEach(viewModel.dishCategories){ index, category  in
                                // Menu Card View...
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
                // Setting Coordinate Space name for offset..
                .coordinateSpace(name: "SCROLL")
            }
            // Setting first tab...
            .onAppear {
                currentTab = viewModel.dishCategories.first?.name ?? ""
            }
        }
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
    }
}
    
            
            
            
            
//            ScrollViewReader { proxy in
//                VStack{
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack (alignment: VerticalAlignment.center, spacing: 5){
//                            IndexedForEach(viewModel.dishCategories) { index, category in
//                                Button(action: {
//                                    withAnimation {
//                                        proxy.scrollTo(category._id, anchor: .top)
//                                    }
//                                    viewModel.selectedCategoryId = category._id
//                                }) {
//                                    Text(category.name)
//                                        .fontWeight(viewModel.selectedCategory?._id == category._id ? .bold : .regular)
//                                        .overlay(viewModel.selectedCategory?._id == category._id ? RoundedRectangle(cornerRadius: .infinity).shadow(color: Color.red, radius: 2.5, x: 0, y: 1).foregroundColor(Color.red).frame(height: 3).offset(y: 5) : nil, alignment: .bottom)
//                                        .foregroundColor(colorScheme == .dark ? .white : .black)
//                                        .padding(.top, 12)
//                                        .padding(.bottom, 12)
//                                }
//                                Spacer()
//                                Divider()
//                                Spacer()
//                            }.onAppear() {
//                                !menuLoaded ? viewModel.selectedCategoryId = viewModel.dishCategories[0]._id : nil
//                            }
//                        }
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding(.leading, 20)
//                    }
//
//                    List {
//                        IndexedForEach(viewModel.dishCategories) { index, category in
//                            Section(header: Text(category.name).padding(.leading, 20).padding(.bottom, -10)){
//                                ForEach(viewModel.dishes.filter { $0.category_id == category._id }, id: \._id) { dish in
//                                        ZStack{
//                                            Button("") {}
//                                            NavigationLink(destination: DishDetailView(dish: dish)){
//                                                ZStack {
//                                                    WebImage(url: URL(string: dish.url_logo))
//                                                      .onSuccess { image, data, cacheType in
//                                                      }
//                                                      .resizable()
//                                                      .placeholder {
//                                                        Rectangle().foregroundColor(.gray)
//                                                      }
//                                                      .indicator(.activity)
//                                                      .transition(.fade(duration: 0.5))
//                                                      .scaledToFit()
//                                                        .aspectRatio(contentMode: .fill)
//                                                        .frame(width: 126, height: 83, alignment: .center)
//                                                        .cornerRadius(13)
//                                                        .frame(maxWidth: .infinity, alignment: .center)
//                                                        .shadow(radius: 6, x: 3, y: 3)
//                                                    if (dish.url_model != "") {
//                                                        Image(systemName: "arkit")
//                                                            .font(.system(size: 16, weight: .light, design: .rounded))
//                                                            .padding(5)
//                                                            .background(
//                                                                Blur(style: .systemUltraThinMaterial)
//                                                            ).cornerRadius(13).offset(x: -42, y: -20)
//                                                    }
//                                                }
//
//                                                Text(dish.name).multilineTextAlignment(.leading)
//                                                    .padding(.leading, 10)
//                                                Spacer()
//                                                Text("\(String(describing: dish.price))0 €").bold().multilineTextAlignment(.center)
//                                                Spacer().frame(width: 5)
//                                            }
//                                    }
//                                }
//                            }.id(category._id)
//                        }.onAppear() {
//                            self.menuLoaded = true
//                        }
//                        .navigationBarTitle(self.viewModel.restaurant.name, displayMode: .automatic)
//                        .padding(.top, 20)
//                        .padding(.bottom, 20)
//                    }
//                    .listStyle(InsetGroupedListStyle())
//                    .padding(.horizontal, -20).progressViewStyle(CircularProgressViewStyle())
//                }.onAppear() {
//                    if self.viewModel.restaurant.name == "" {
//                        self.showAlert = true
//                        tapticFail()
//                    }
//                }
//            }
        
    


//    .accentColor( .red).alert(isPresented: $showAlert) {
//        Alert(
//             title: Text("Aucun restaurant"),
//            message: Text("Veuillez scanner un QR Code afin de récupérer le menu du restaurant"),
//            dismissButton: .cancel(Text("Ouvrir le scanneur"), action: {
//                DispatchQueue.main.async{
//                    withAnimation(.easeOut(duration: 0.2)) {
//                        self.viewRouter.currentPage = "qrcode.viewfinder"
//                    }
//                }
//            }))
//    }

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(restaurant: RestaurantDTO(_id: "6007fabd63c8d10017d2b3ba", name: "Minute Asia"), selectedTab: "greetingcard.fill")
//
//    }
//}

struct MenuCardView: View{
    var dishCategory: DishCategory
    var dishes: [Dish]
    @Binding var currentTab: String

    var body: some View{
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text(dishCategory.name ?? "")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .padding(.vertical)
            
            ForEach(dishes.filter { $0.category_id == dishCategory._id }, id: \._id) { dish in
                
//            IndexedForEach(dishes) { index, dish  in
//                Section(header: Text(category.name).padding(.leading, 20).padding(.bottom, -10)){
            
//            ForEach(dishes.filter { $0.category_id == category._id }, id: \._id) { dish in
                
                // Food View...
//                ZStack{
//                    Button("") {}
//                    NavigationLink(destination: DishDetailView(dish: dish)){
//                        ZStack {
//
//                            WebImage(url: URL(string: dish.url_logo))
//                             .onSuccess { image, data, cacheType in
//                             }
//                             .resizable()
//                             .placeholder {
//                               Rectangle().foregroundColor(.gray)
//                             }
//                             .indicator(.activity)
//                             .transition(.fade(duration: 0.5))
//                             .scaledToFit()
//                               .aspectRatio(contentMode: .fill)
//                               .frame(width: 126, height: 83, alignment: .center)
//                               .cornerRadius(13)
//                               .frame(maxWidth: .infinity, alignment: .center)
//                               .shadow(radius: 6, x: 3, y: 3)
//                           if (dish.url_model != "") {
//                               Image(systemName: "arkit")
//                                   .font(.system(size: 16, weight: .light, design: .rounded))
//                                   .padding(5)
//                                   .background(
//                                       Blur(style: .systemUltraThinMaterial)
//                                   ).cornerRadius(13).offset(x: -42, y: -20)
//                           }
//                        }
//                        Spacer()
//                            VStack(alignment: .leading, spacing: 10) {
//
//                                Text(dish.name)
//                                    .multilineTextAlignment(.leading)
//                                    .padding(.leading, 10)
//
//                                Text(dish.ingredients?.joined(separator: ", ") ?? "")
//                                    .font(.caption)
//                                    .foregroundColor(.gray)
//
//                                Text("\(String(describing: dish.price))0 €").bold().multilineTextAlignment(.center)
//                            }
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        Spacer().frame(width: 5)
//
//                    }
//                }
                
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
                                .frame(width: 135, height: 150, alignment: .center)
                                .cornerRadius(13)
                                .frame(maxWidth: 149, alignment: .leading)
                                .shadow(radius: 6, x: 3, y: 3)
                            if (dish.url_model != "") {
                                Image(systemName: "arkit")
                                    .font(.system(size: 16, weight: .light, design: .rounded))
                                    .padding(5)
                                    .background(
                                        Blur(style: .systemUltraThinMaterial)
                                    ).cornerRadius(13).offset(x: -50, y: -50)
                                    .foregroundColor(.primary)
                            }
                        }

                    VStack(alignment: .leading, spacing: 10) {

                        Text(dish.name)
                            .multilineTextAlignment(.leading)
                            .font(.title3.bold())
                            .foregroundColor(.themeTextField)

                        Text(dish.ingredients?.joined(separator: ", ") ?? "")
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)

                        Text("\(String(describing: dish.price))0 €").font(.callout).bold()
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 3)
                            .padding(.horizontal, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 6).foregroundColor(.orange)
                            ).foregroundColor(.white)
                            
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    }
            }
                
                Divider()
            }
//                                     }
        }
        .modifier(OffsetModifier(dishCategory: dishCategory, currentTab: $currentTab))
        // setting ID for Scroll View Reader...
        .id(dishCategory.name)
    }
        
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(restaurant: RestaurantDTO(_id: "6007fabd63c8d10017d2b3ba", name: "Minute Asia"))

    }
}


struct OffsetModifier: ViewModifier {

    var dishCategory: DishCategory
    @Binding var currentTab: String
    
    func body(content: Content) -> some View {
        
        content
            .overlay(
            
                // Getting Scroll Offset using Geometry Reader...
                GeometryReader{proxy in
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey.self) { proxy in
                
                // if minY is between 20 to -half of the midX
                // then updating current tab....
                
                let offset = proxy.minY
                
                // Since on change on Home is Updating Scrolll...
                // to avoid that...
                
                // ADDING "SCROLL" TO LAST OF ID...
                // TO IDENTIFY EASILY....

                withAnimation{
                    currentTab = (offset < 20 && -offset < (proxy.midX / 2) && currentTab != dishCategory.name ) ?  dishCategory.name : currentTab
                }
            }
    }
}

struct OffsetModifier_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Prefrence Key...
struct OffsetKey: PreferenceKey{
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

