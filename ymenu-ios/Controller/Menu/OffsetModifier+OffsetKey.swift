//
//  OffsetModifier.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 29/03/2022.
//

import Foundation
import SwiftUI

struct OffsetModifier: ViewModifier {

    var dishCategory: DishCategory
    @Binding var currentTab: String
    
    func body(content: Content) -> some View {
        
        content
            .overlay(
                GeometryReader{proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey.self) { proxy in
                let offset = proxy.minY
                withAnimation{
                    currentTab = (offset < 20 && -offset < (proxy.midX / 2) && currentTab != dishCategory.name ) ?  dishCategory.name : currentTab
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

