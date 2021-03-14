//
//  PageView.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 09/01/2021.
//

import SwiftUI

struct PageView<Page:View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    @Binding var isOnboardingDone: Bool
    
    @State var currentPage:Int = 0
    
    init(_ views: [Page], isOnboardingDone: Binding<Bool>) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        self._isOnboardingDone = isOnboardingDone
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.1))
                    
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            Spacer()
        VStack{
            Spacer()
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
            Button(action: {
                if self.currentPage < self.viewControllers.count - 1 {
                    self.currentPage += 1
                } else {
                    isOnboardingDone.toggle()
                }
            }) {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 180, height: 70)
//                    .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                    .foregroundColor(Color.orange)
                    .padding()
                        .shadow(radius: 5, x: 2, y: 2)
                        .border(Color.black, width: 0)
                    .overlay(
                        Text(self.currentPage < self.viewControllers.count - 1 ? "Suivant" : "C'est parti !" )
                        .foregroundColor(.white)
                            .font(.custom("SF Pro Text Bold", size: 25))
                    )
            }.padding(.bottom, 60)
        }.edgesIgnoringSafeArea(.all)
        .offset(y: 0)
        }.edgesIgnoringSafeArea(.all)
           
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(cards.map { OnboardingCardView(card: $0) }, isOnboardingDone: .constant(false))
    }
}
