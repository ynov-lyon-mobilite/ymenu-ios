//
//  LoginViewModel.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 31/03/2021.
//

import Foundation
import SwiftUI

class LoginViewModel: RoutingProvider {
    var loginWebService = LoginWebService()
    
    @Published var mail: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var wrongCredentials: Bool = false
    
    func handleLogin() {
        let parameters = LoginWebServiceParameters(mail: mail, password: password)
        loginWebService.call(parameters: parameters)

        execute(with: loginWebService) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    withAnimation {self.wrongCredentials = true}
                    self.isLoading = false
                }
                print(error)
            case .success(let tokenPair):
                DispatchQueue.main.async {
                    UserDefaults.standard.set(tokenPair.user.mail,forKey: "mail")
                    UserDefaults.standard.set(tokenPair.user.firstname,forKey: "firstname")
                    UserDefaults.standard.set(tokenPair.user.lastname,forKey: "lastname")
                    withAnimation {ApplicationState.shared.authenticate(with: tokenPair)}
                    self.isLoading = false
                }
            }
        }
    }
}
