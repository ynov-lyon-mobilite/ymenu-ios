//
//  LoginWebService.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 31/03/2021.
//

import Foundation

struct LoginWebServiceParameters: Encodable {
    let mail: String
    let password: String
}

struct TokenPairResponse: Decodable {
    let token: String
//    let refreshToken: String
    let user: User
}

class LoginWebService: Routing {
    typealias DecodeType = TokenPairResponse
    
    let baseURL: Hostname = .api
    let path: String = "/user/login"
    let authenticationType: AuthenticationType = .none
    
    var parameters: LoginWebServiceParameters?
    
    func call(parameters: LoginWebServiceParameters) {
        self.parameters = parameters
    }
}
