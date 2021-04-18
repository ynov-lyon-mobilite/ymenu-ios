//
//  LoginViewModel.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 18/04/2021
//

import Foundation
import SwiftUI

class RegisterViewModel: RoutingProvider {
    var registerWebService = RegisterWebService()
    
    @Published var mail: String = ""
    @Published var password: String = ""
    @Published var confirmpassword: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var isLoading: Bool = false
    @Published var wrongCredentials: Bool = false
    
    func handleRegister() {
        let parameters = RegisterWebServiceParameters(firstname: firstname, lastname: lastname, history: [], role: "ROLE_USER", mail: mail, password: password)
        registerWebService.call(parameters: parameters)

        execute(with: registerWebService) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    withAnimation {self.wrongCredentials = true}
                    self.isLoading = false
                }
                print(error)
            case .success(let tokenPair):
                DispatchQueue.main.async {
//                    withAnimation {ApplicationState.shared.authenticate(with: tokenPair)}
                    self.isLoading = false
                }
            }
        }
    }
}
