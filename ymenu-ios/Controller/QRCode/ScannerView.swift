//
//  ScannerView.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 25/11/2020.
//

import SwiftUI

struct ScannerView: View {
    @Binding var selectedTab: String
    @Binding var restaurant: RestaurantDTO
    
    @ObservedObject var viewModel = ScannerViewModel()

    var body: some View {
        ZStack {
            QrCodeScannerView()
            .found(r: self.viewModel.onFoundQrCode)
            .torchLight(isOn: self.viewModel.torchIsOn)
            .interval(delay: self.viewModel.scanInterval)
            
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Veuillez scanner un code QR").foregroundColor(.black)
                            .font(.subheadline).bold()
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(
                        Blur(
                             style: .systemUltraThinMaterial)
                        )
                    .cornerRadius(.greatestFiniteMagnitude)
                }
                .padding(.vertical, 60)
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(
                        Image(systemName: "viewfinder").foregroundColor(.white).font(.system(size: 300).weight(.ultraLight))
                    )
                Spacer()
                HStack {
                    Button(action: {
                        self.viewModel.torchIsOn.toggle()
                    }, label: {
                        Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.black)
                            .padding()
                    })
                }
                .background(
                    Blur(
                         style: .systemUltraThinMaterial)
                    )
                .cornerRadius(10)
            }.padding()
        }
        .onChange(of: self.viewModel.lastQrCode) { (_) in
            print("qrCode change: ", self.viewModel.lastQrCode)
            
            let result = self.viewModel.lastQrCode.components(separatedBy: ", ")
            
            restaurant = RestaurantDTO(_id: result[0], name: result[1])
            selectedTab = "greetingcard.fill"
        }
    }
}
