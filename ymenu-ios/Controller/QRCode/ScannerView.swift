//
//  ScannerView.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 25/11/2020.
//

import SwiftUI

struct ScannerView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showAlert: Bool = false
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var viewModel = ScannerViewModel()
    @ObservedObject var qrCodeViewModel = QrCodeScannerViewModel()
    
    func tapticSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func tapticFail() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
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
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("Veuillez scanner un code QR")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
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
                .padding(.top, 60)
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(
                        Image(systemName: "viewfinder")
                            .font(.system(size: 300, weight: .ultraLight))
                            .foregroundColor(.white)
                    )
                Spacer()
                // TODO: [Issue] Activating the flash disables the scan interval entirely, even when turned off. App needs to be restarted to fix
//                HStack {
//                    Button(action: {
//                        self.viewModel.torchIsOn.toggle()
//                    }, label: {
//                        Image(systemName: self.viewModel.torchIsOn ? "flashlight.on.fill" : "flashlight.off.fill").font(.system(size: 25))
//                            .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.black)
//                            .padding()
//                    })
//                }
//                .frame(width: 65, height: 65)
//                .background(
//                    Blur(
//                        style: self.viewModel.torchIsOn ? .systemUltraThinMaterialDark : .systemUltraThinMaterialLight)
//                    )
//                .cornerRadius(.greatestFiniteMagnitude)
            }.padding(.bottom, 20)
        }
        .onChange(of: self.viewModel.lastQrCode) { (_) in
            print("qrCode change: ", self.viewModel.lastQrCode)
    
            let result = self.viewModel.lastQrCode.components(separatedBy: ", ")
//          TODO: Handle QR codes passing the regex but not sending back data from the API
            if (self.viewModel.lastQrCode.range(of: #"^(\w{24}), [a-zA-Z0-9_ ]*"#,
                                options: .regularExpression) != nil){
                viewRouter.restaurant = RestaurantDTO(_id: result[0], name: result[1])
                
                self.viewRouter.currentPage = "greetingcard.fill"
                tapticSuccess()
            } else {
                tapticFail()
                self.showAlert = true
            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("QR code incompatible"),
                message: Text("Veuillez scanner un QR Code compatible afin de récupérer le menu d'un restaurant"),
                dismissButton: .cancel(Text("Réessayer"), action: {
                    self.viewRouter.currentPage = ""
                    DispatchQueue.main.async {
                        withAnimation { self.viewRouter.currentPage = "qrcode.viewfinder" }
                    }
                }))
        }
    }
}
