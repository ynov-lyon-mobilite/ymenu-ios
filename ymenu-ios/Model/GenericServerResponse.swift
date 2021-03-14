//
//  GenericServerResponse.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 23/11/2020.
//

import Foundation

class GenericServerResponse<T: Decodable>: Decodable {
    let data: T
}
