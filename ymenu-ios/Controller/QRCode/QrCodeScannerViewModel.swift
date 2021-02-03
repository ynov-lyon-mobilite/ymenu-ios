//
//  QrCodeScannerViewModel.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 03/02/2021.
//

import Foundation
import UIKit

class QrCodeScannerViewModel: ObservableObject {
    @Published var isReload: Bool = false
    
    func setReload() {
        isReload = true
    }
}
