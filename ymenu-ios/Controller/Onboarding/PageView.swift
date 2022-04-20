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
    
    @State var currentPage: Int = 0
    
    init(_ views: [Page], isOnboardingDone: Binding<Bool>) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        self._isOnboardingDone = isOnboardingDone
    }
    

    
    var body: some View {
        ZStack(alignment: .center) {
            Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.1))

            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            if (self.currentPage != 0) {
                onBoardingImageView(image: self.currentPage < self.viewControllers.count - 1 ? "dish1" : "picture3")
            } else {
                Image("logoymenu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120, alignment: .center)
                    .padding(25)
                    .background(RoundedRectangle(cornerRadius: 35).foregroundColor(.white))
            }
            ZStack {
            Spacer()
            VStack{

               
                Spacer()
                Button(action: {
                    if self.currentPage < self.viewControllers.count - 1 {
                        self.currentPage += 1
                    } else {
                        isOnboardingDone.toggle()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 360, height: 70)
    //                    .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                        .foregroundColor(Color.themeTextField)
                        .padding()
    //                        .shadow(radius: 5, x: 2, y: 2)
    //                        .border(Color.black, width: 0)
                        .overlay(
                            Text(self.currentPage < self.viewControllers.count - 2 ? "Découvrir" : "Suivant" )
                            .foregroundColor(.white)
                                .font(.custom("SF Pro Rounded Regular", size: 20))
                        )
                }
            }.edgesIgnoringSafeArea(.all)
            }
        .offset(y: 0)
        }.edgesIgnoringSafeArea(.all)
        PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage).padding(.bottom, 90)
    }
}

struct onBoardingImageView: View {
    var image: String
    
    var body: some View {
        Image(self.image)
            .resizable()
            .scaledToFill()
            .frame(height: 500)
                .offset(x: 20, y: 100)
            .clipShape(Circle())
            .frame(width: 500)
            .overlay(Circle().stroke(Color.themeTextField, lineWidth: 3))
            .shadow(radius: 10)
                .offset(x: 20, y: -400)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(cards.map { OnboardingCardView(card: $0) }, isOnboardingDone: .constant(false))
    }
}
