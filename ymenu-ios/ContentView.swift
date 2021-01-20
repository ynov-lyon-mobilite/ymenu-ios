//
//  ContentView.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 11/10/2020.
//

import SwiftUI
import RealityKit


var cards:[OnboardingCard] = [
OnboardingCard(image: "logoymenu", title: "Bienvenue dans Y'menu", description: "A travers cette application vous pourrez découvrir les différents menus proposés en réalité augmentée. Voyez votre plat sur votre tables avant même de l'avoir commandé."),
OnboardingCard(image: "logoymenu", title: "Comment ça marche ?", description: "Ouvrez votre caméra grâce a la fonctionnalité QR Code disponible sur l'écran d'accueil, scannez le QR Code et c'est prêt !"),
OnboardingCard(image: "logoymenu", title: "Bon appétit !", description: "Si vous avez bien compris le fonctionnement, il ne vous reste plus qu'a essayer !")
]



struct ContentView : View {

    
    @State var isOnboardingDone = false
    
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

//struct ARViewContainer: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> ARView {
//
//        let arView = ARView(frame: .zero)
//
//        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
//
//        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
//
//        return arView
//
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {}
//
//}


struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .padding()
    }
}




struct Home: View {
    @State var selectedTab = "qrcode.viewfinder"
    @State var restaurant: RestaurantDTO = RestaurantDTO(_id: "", name: "")
    @Namespace var animation : Namespace.ID
    @StateObject var modelData = ModelView()
    
    var body: some View{
        VStack(spacing : 0){
            
            GeometryReader{_ in
                
                ZStack{
                    // tabs
                    MenuView(viewModel: MenuViewModel(restaurant: restaurant))
                        .opacity(selectedTab == "greetingcard.fill" ? 1 : 0)
                    
                    ScannerView(selectedTab: $selectedTab, restaurant: $restaurant)
                        .opacity(selectedTab == "qrcode.viewfinder" ? 1 : 0)
                    
                    Text("Paramètres")
                        .opacity(selectedTab == "person.fill" ? 1 : 0)
                }
            }
            .onChange(of: selectedTab) { (_) in
                switch(selectedTab){
                
                case "greetingcard.fill": if !modelData.isHomeLoad{modelData.loadHome()}
                case "qrcode.viewfinder": if !modelData.isQRLoad{modelData.loadQR()}
                case "person.fill": if !modelData.isSettingLoad{modelData.loadSetting()}
                default: ()
                }
            }
            // tab view
            Divider()
                .padding(.bottom,13)
                .background(Color.white)

            HStack(spacing: 0){
                 ForEach(tabs,id: \.self){tab in
                    
                    TabButton(title: tab, selectedTab: $selectedTab, animation: animation)
                    
                    if tab != tabs.last{
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal,30)
            .background(Color.white)
            
        }
    }
}

//tabButton

struct TabButton : View{
    var title : String
    @Binding var selectedTab : String
    var animation : Namespace.ID
    
    var body: some View{
        Button(action: {
            withAnimation{selectedTab = title}
        }){
            VStack(spacing: 6){
                Image(systemName: title)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedTab == title ? Color(.black) : Color.black.opacity(0.4))
                    .frame(width: 29, height: 30)
                VStack{
                    CustomShape()
                        .fill(Color.clear)
                        .frame(width: 45, height: 6)
                    if selectedTab == title{
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


class ModelView : ObservableObject{
    @Published var isHomeLoad = false
    @Published var isQRLoad = false
    @Published var isSettingLoad = false
    
    init() {
        print("Home Data load")
    }
    
    func loadHome(){
        print("Home Loaded")
        isHomeLoad = true
    }
    
    func loadQR(){
        print("QR Loaded")
        isQRLoad = true
    }
    
    func loadSetting(){
        print("Setting Loaded")
        isSettingLoad = true
    }
}


