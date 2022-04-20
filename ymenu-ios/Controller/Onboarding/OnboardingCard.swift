//
//  OnboardingCard.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 09/01/2021.
//

import Foundation

struct OnboardingCard: Identifiable {
    var id = UUID()
    var image:String
    var title:String
    var subtitle:String!
    var description1:String!
    var description2:String!
}
