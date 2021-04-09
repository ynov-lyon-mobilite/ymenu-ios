//
//  AccountView.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 31/03/2021.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var applicationState: ApplicationState = ApplicationState.shared
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack {
            Group {
                switch applicationState.state {
                case .authenticated:
                    Button(action: {
                        applicationState.disconnect()
                        print(applicationState.state)
                    }) {
                        HStack {
                            Text("Déconnexion")
                                .bold()
                        }}.padding()
                    .foregroundColor(.white)
                    .padding([.trailing, .leading], 50)
                    .background(Color.themeTextField)
                    .cornerRadius(.greatestFiniteMagnitude)
                    .shadow(radius: 6, x: 3, y: 3)
                    .padding(.top, 40)
                case .loading:
                    Text("Loading ...")
                case .requireLogin:
                    LoginView(viewModel: LoginViewModel())
                }
            }
        }.onAppear(perform: {
            applicationState.startApplication()
        })
    }
}

