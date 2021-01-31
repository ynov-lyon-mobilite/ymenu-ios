//
//  IndexedForEach.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI

struct IndexedForEach<D, V: View>: View {
    let data: [D]
    let content: (Int, D) -> V
    
    var body: some View {
        ForEach(data.indices, id: \.self) { index in
            self.content(index, data[index])
        }
    }
    
    init(_ data: [D], @ViewBuilder content: @escaping (Int, D) -> V) {
        self.data = data
        self.content = content
    }
}
