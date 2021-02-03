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
        ZStack{
            Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.1))
                    .edgesIgnoringSafeArea(.all)
        VStack{
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            Spacer()
            Button(action: {
                if self.currentPage < self.viewControllers.count - 1 {
                    self.currentPage += 1
                } else {
                    isOnboardingDone.toggle()
                }
            }) {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 180, height: 70)
                    .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                    .padding()
                        .shadow(color: .black, radius: 3)
                        .border(Color.black, width: 0)
                    .overlay(
                        Text(self.currentPage < self.viewControllers.count - 1 ? "Suivant" : "C'est parti !" )
                        .foregroundColor(.white)
                            .font(.custom("Helvetica-Bold", size: 28))
                        
                    )
            }
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
        }
        }
        
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(cards.map { OnboardingCardView(card: $0) }, isOnboardingDone: .constant(false))
    }
}
