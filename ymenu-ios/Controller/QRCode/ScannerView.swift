//
//  ScannerView.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 25/11/2020.
//

import SwiftUI

struct ScannerView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    
    var body: some View {
        ZStack {
            QrCodeScannerView ()
                .found (r: self .viewModel.onFoundQrCode)
                .torchLight (isOn: self .viewModel.torchIsOn)
                .interval (delay: self .viewModel.scanInterval)
    
            VStack {
                VStack {
                    Text(self.viewModel.lastQrCode)
                        .bold()
                        .lineLimit(20)
                        .padding()
                }
                .padding(.vertical, 15)
                
                Spacer()
                HStack {
                    Button(action: {
                        self.viewModel.torchIsOn.toggle()
                    }, label: {
                        Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.blue)
                            .padding()
                    })
                }
                .background(Color.white)
                .cornerRadius(10)
                
            }.padding()
        }
    }
}
