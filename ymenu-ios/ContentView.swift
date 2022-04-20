//
//  ContentView.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 11/10/2020.
//

import SwiftUI

var cards:[OnboardingCard] = [
    OnboardingCard(image: "logoymenu", title: "Vos plats en réalité augmenté"),
    OnboardingCard(image: "dish1", title: "Bienvenue dans Y'Menu", subtitle: "Une expérience unique en réalité augmenté", description1: "À travers cette application vous pourrez découvrir les différents plats du menu proposés en réalité augmentée.", description2: "Visualisez votre plat sur votre table avant même de l'avoir commandé."),
    OnboardingCard(image: "dish1", title: "Comment ça marche ?", description1: "Ouvrez votre caméra grâce à la fonctionnalité QR Code disponible sur l'écran d'accueil, scannez le QR Code et c'est prêt !", description2: "Si vous avez bien compris le fonctionnement, il ne vous reste plus qu'à essayer !"),
    ]

struct ContentView : View {

    @AppStorage("mustDisplayOnBoarding") var isOnboardingDone: Bool = false
    
    var body: some View {
        Group {
            if isOnboardingDone {
                Home()
            } else {
                PageView(cards.map { OnboardingCardView(card: $0) }, isOnboardingDone: $isOnboardingDone)
            }
        }
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @EnvironmentObject var viewRouter: ViewRouter
//    @State var restaurant: RestaurantDTO = RestaurantDTO(_id: "", name: "")
    @Namespace var animation : Namespace.ID
    
    
    var body: some View{
        VStack(spacing : 0){
            GeometryReader{_ in
                ZStack{
                    switch(viewRouter.currentPage){
                        case "greetingcard.fill": MenuView(restaurant: viewRouter.restaurant)
                            .opacity(viewRouter.currentPage == "greetingcard.fill" ? 1 : 0)
                        case "qrcode.viewfinder": ScannerView().edgesIgnoringSafeArea(.top)
                            .opacity(viewRouter.currentPage == "qrcode.viewfinder" ? 1 : 0)
                        case "person.fill":  AccountView()
                            .opacity(viewRouter.currentPage == "person.fill" ? 1 : 0)
                        default: EmptyView()
                    }
                }
            }
            // tab view
            Divider()
                .padding(.bottom,13)

            HStack(spacing: 0){
                 ForEach(tabs,id: \.self){tab in
                    
                    TabButton(title: tab, animation: animation)
                    
                    if tab != tabs.last{
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal,30)
        }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

//tabButton
struct TabButton : View{
    @Environment(\.colorScheme) var colorScheme
    var title : String
    @EnvironmentObject var viewRouter: ViewRouter
    var animation : Namespace.ID
    
    var body: some View{
        Button(action: {
            if viewRouter.currentPage != title {
                DispatchQueue.main.async{
                    withAnimation(.easeOut(duration: 0.2)) {
                        viewRouter.currentPage = title
                    }
                }
            }
        }){
            VStack(spacing: 6){
                Image(systemName: title)
                    .resizable()
                    .opacity(viewRouter.currentPage == title ? 1 : 0.4)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 29, height: 30)
                VStack{
                    CustomShape()
                        .fill(Color.clear)
                        .frame(width: 45, height: 6)
                    if viewRouter.currentPage == title{
                        CustomShape()
                            .fill(Color.red).cornerRadius(3.0)
                            .frame(width: 35, height: 5)
                            .matchedGeometryEffect(id: "Tab_change", in: animation)
                    }
                }
                .padding(.top,-11)
            }
        }
    }
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 20))
        
        return Path(path.cgPath)
    }
}

var tabs = ["greetingcard.fill","qrcode.viewfinder","person.fill"]
