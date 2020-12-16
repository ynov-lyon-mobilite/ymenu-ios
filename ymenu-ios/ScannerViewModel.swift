//
//  ScannerViewModel.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 25/11/2020.
//

import Foundation

class ScannerViewModel: ObservableObject {
    
    let scanInterval: Double = 1.0
    
    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = ""
    
    
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }
}
