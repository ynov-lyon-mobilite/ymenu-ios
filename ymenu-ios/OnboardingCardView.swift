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
                .background(LinearGradient(gradient: Gradient(colors: [.gray, Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0))]), startPoint: .bottomTrailing, endPoint: .topLeading))
            VStack{
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 145, height: 145, alignment: .center)
                Text(card.title)
                    .font(.custom("Ubuntu-Bold", size: 40))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 235/255, green: 165/255, blue: 60/255))
                Text(card.description)
                    .font(.custom("Ubuntu-Regular", size: 25))
                    .lineLimit(7)
                    .multilineTextAlignment(.center)
                    .padding()
            }.padding()
        }
    }
}



struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(card: cards[0])
    }
}
