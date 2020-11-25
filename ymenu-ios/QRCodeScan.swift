//
//  QRCodeScan.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 25/11/2020.
//

import SwiftUI

struct QRCodeScan: UIViewControllerRepresentable {

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> ScannerViewController {
        let vc = ScannerViewController()
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ vc: ScannerViewController, context: Context) {
    }

    class Coordinator: NSObject, QRCodeScannerDelegate {
        @State var barcode = ""
        func codeDidFind(_ code: String) {
            barcode = code
            (self.$barcode) //This creates a sheet at the bottom of the screen, saying if a product was found with the barcode
        }
        var parent: QRCodeScan

        init(_ parent: QRCodeScan) {
            self.parent = parent
        }
    }
}
