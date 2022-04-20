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
                    UserDefaults.standard.set("https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80", forKey: "profilImage")
                    withAnimation {ApplicationState.shared.authenticate(with: tokenPair)}
                    self.isLoading = false
                }
            }
        }
    }
}
