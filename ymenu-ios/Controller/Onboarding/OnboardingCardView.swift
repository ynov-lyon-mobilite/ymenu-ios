//
//  OnboardingCardView.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 09/01/2021.
//

import SwiftUI

struct OnboardingCardView: View {
    
    var card:OnboardingCard
    
    var body: some View {

        ZStack{
            Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.1))
                    .edgesIgnoringSafeArea(.all)
            VStack{
                
//            Image(card.image)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 500)
//                    .offset(x: 20, y: 100)
//                    .clipShape(Circle())
//                    .frame(width: 500)
//                    .overlay((card.image != "picture3") ? AnyView(Circle().stroke(Color.themeTextField, lineWidth: (card.image != "logoymenu") ? 3 : 0)) : AnyView(Rectangle()))
//                    .shadow(radius: card.image != "logoymenu" ? 10 : 0)
//                    .offset(x: 20, y: -400)
            }
            VStack{
            Text(card.title)
                .font(.custom("SF Pro Rounded Regular", size:30))
                .multilineTextAlignment(.center)
                .lineSpacing(5)
//                .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                .foregroundColor(Color.themeTextField)
                .offset(y: -100)
                
            Text(card.subtitle ?? "")
                    .font(.custom("SF Pro Rounded Bold", size:20))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
    //                .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                    .foregroundColor(Color.black)
                    .offset(y: -50)
            }
            VStack{
                Text(card.description1 ?? "")
                    .font(.custom("SF Pro Text Regular", size: 18))
                    .lineLimit(5)
                    .multilineTextAlignment(.center)
                    .padding()
                    .offset(y: 25)
                    .padding()
            }.padding(.top, 20)
            VStack{
                Text(card.description2 ?? "")
                    .font(.custom("SF Pro Text Regular", size: 18))
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .padding()
                    .offset(y: 130)
                    .padding(.top, 10)
            }.padding()
        }.edgesIgnoringSafeArea(.all)
    }
}


struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(card: cards[0])
    }
}
