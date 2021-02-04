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
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 145, height: 145, alignment: .center)
                .padding(.top)
                .padding(.bottom)
                .offset(y: -290)
            }
            VStack{
            Text(card.title)
                .font(.custom("SF Pro Rounded Bold", size: 45))
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                .offset(y: -100)
            }
            VStack{
                Text(card.description)
                    .font(.custom("SF Pro Text Regular", size: 23))
                    .lineLimit(6)
                    .lineSpacing(3)
                    .multilineTextAlignment(.center)
                    .padding()
                    .offset(y: 100)
                    .padding()
            }.padding()
        }.edgesIgnoringSafeArea(.all)
    }
}



struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(card: cards[0])
    }
}
