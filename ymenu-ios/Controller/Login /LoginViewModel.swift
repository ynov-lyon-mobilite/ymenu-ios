//
//  LoginViewModel.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 31/03/2021.
//

import Foundation

class LoginViewModel: RoutingProvider {
    var loginWebService = LoginWebService()
    
    var mail: String = ""
    var password: String = ""
    
    func handleLogin() {
        let parameters = LoginWebServiceParameters(mail: mail, password: password)
        loginWebService.call(parameters: parameters)

        execute(with: loginWebService) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let tokenPair):
                ApplicationState.shared.authenticate(with: tokenPair)
            }
        }
    }
}
