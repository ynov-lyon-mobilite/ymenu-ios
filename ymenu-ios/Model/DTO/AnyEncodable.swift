//
//  AnyEncodable.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 23/11/2020.
//

import Foundation

struct AnyEncodable: Encodable {

    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
