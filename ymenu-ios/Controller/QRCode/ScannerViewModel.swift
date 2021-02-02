//
//  ScannerViewModel.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 25/11/2020.
//

import Foundation

class ScannerViewModel: ObservableObject {
    
    /// Defines how often we are going to try looking for a new QR-code in the camera feed.
    let scanInterval: Double = 1.0
    
    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = "restaurantId"
    
    
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }
}
