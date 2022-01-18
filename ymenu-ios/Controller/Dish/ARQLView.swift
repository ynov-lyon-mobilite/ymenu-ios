//
//  ARQLView.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 13/01/2022.
//

import SwiftUI
import QuickLook

struct ARQLView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARQuickLookViewController
    @Binding var filePath: String
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> ARQuickLookViewController {
        let viewController = ARQuickLookViewController(filePath: filePath, isPresented: isPresented, rootView: self)
        return viewController
    }
    
    func dismiss() {
        self.isPresented = false
    }
    
    func updateUIViewController(_ uiViewController: ARQuickLookViewController, context: Context) {}
    
    class Coordinator: NSObject {
        var parent: ARQLView
        init(_ parent: ARQLView){
            self.parent = parent
            super.init()
        }
    }
}
