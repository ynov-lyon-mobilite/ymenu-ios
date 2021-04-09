//
//  HistoryTopBarView.swift
//  ymenu-ios
//
//  Created by Antoine Mousset on 31/03/2021.
//

import SwiftUI

struct HistoryTopBarView: View {
    @State var label: String
    
    var body: some View {
        ZStack {
            Text(label)
                .lineLimit(1)
        }
    }
}

struct HistoryTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTopBarView(label: "TestCategory")
    }
}
