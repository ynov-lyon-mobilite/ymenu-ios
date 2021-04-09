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
                    HistoryView(viewModel: HistoryViewModel())
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

