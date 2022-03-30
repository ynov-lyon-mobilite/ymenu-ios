//
//  RegisterViewModel.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 18/04/2021
//

import Foundation
import SwiftUI
import Combine

class RegisterViewModel: RoutingProvider {
    var registerWebService = RegisterWebService()
    
    @Published var mail: String = ""
    @Published var password: String = ""
    @Published var confirmpassword: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var pseudo: String = ""
    @Published var isLoading: Bool = false
    @Published var accountExist: Bool = false
    @Published var error: Bool = false

    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    
    private var dismissRegister = false {
        didSet {
            viewDismissalModePublisher.send(dismissRegister)
        }
    }
    
    func handleRegister() {
        let parameters = RegisterWebServiceParameters(firstname: firstname, lastname: lastname, history: [], role: "ROLE_USER", mail: mail, password: password)
        registerWebService.call(parameters: parameters)

        execute(with: registerWebService) { result in
            switch result {
            case .failure(let error):
                let errorCode = (error as NSError).code
                DispatchQueue.main.async {
                    if errorCode != 400 {
                        withAnimation {self.error = true}
                    } else {
                        withAnimation {self.accountExist = true}
                    }
                    self.isLoading = false
                }
                print(error)
            case .success:
                DispatchQueue.main.async {
//                    withAnimation {ApplicationState.shared.authenticate(with: tokenPair)}
                    self.dismissRegister = true
                    self.isLoading = false
                }
            }
        }
    }
}
