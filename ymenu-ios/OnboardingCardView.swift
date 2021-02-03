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
                    .offset(y: -100)
                Text(card.title)
                    .font(.custom("SF Pro Rounded Bold", size: 40))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                    .offset(y: -80)
                Text(card.description)
                    .font(.custom("SF Pro Text Regular", size: 25))
                    .lineLimit(7)
                    .multilineTextAlignment(.center)
                    .padding()
                    .offset(y: -40)
            }.padding()
        }.edgesIgnoringSafeArea(.all)
    }
}



struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(card: cards[0])
    }
}
