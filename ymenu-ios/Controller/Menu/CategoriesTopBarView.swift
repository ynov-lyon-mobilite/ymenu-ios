//
//  CategoriesTopBarView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI

struct CategoriesTopBarView: View {
    @State var label: String
    
    var body: some View {
        ZStack {
            Text(label)
                .lineLimit(1)
        }
    }
}

struct CategoriesTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesTopBarView(label: "TestCategory")
    }
}
