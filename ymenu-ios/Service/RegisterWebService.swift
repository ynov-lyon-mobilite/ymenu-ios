//
//  LoginWebService.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 18/04/2021.
//

import Foundation

struct RegisterWebServiceParameters: Encodable {
    let firstname: String
        let lastname: String
        let history: [String]
        let role: String
        let mail: String
        let password: String
}

class RegisterWebService: Routing {
    typealias DecodeType = EmptyCodable
    
    let baseURL: Hostname = .api
    let path: String = "/user"
    let method: HTTPMethod = .PUT
    let authenticationType: AuthenticationType = .none
    
    var parameters: RegisterWebServiceParameters?
    
    func call(parameters: RegisterWebServiceParameters) {
        self.parameters = parameters
    }
}
