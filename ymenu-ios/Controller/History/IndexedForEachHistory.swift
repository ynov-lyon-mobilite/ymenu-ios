//
//  IndexedForEachHistory.swift
//  ymenu-ios
//
//  Created by Antoine Mousset on 31/03/2021.
//

import SwiftUI

struct IndexedForEachHistory<D, V: View>: View {
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
