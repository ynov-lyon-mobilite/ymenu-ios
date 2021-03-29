//
//  ARQuickLook.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 29/01/2021.
//

import SwiftUI
import QuickLook
import ARKit

struct ARQuickLookView: UIViewControllerRepresentable {
    @Binding var filePath: String
    var title: String
    var allowScaling: Bool = true

    @Binding var isPresented: Bool

    func makeCoordinator() -> ARQuickLookView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        controller.additionalSafeAreaInsets.top = 25
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }

    func updateUIViewController(_ controller: UINavigationController, context: Context) {}
    
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let parent: ARQuickLookView
        
        init(_ parent: ARQuickLookView) {
            self.parent = parent
            super.init()
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            let item = ARQuickLookPreviewItem(fileAt: URL(string: parent.filePath)!)
                     item.allowsContentScaling = parent.allowScaling
                     item.canonicalWebPageURL = nil
                     return item
        }

        @objc func dismiss(_ controller: QLPreviewController) {
            parent.isPresented = false
        }
    }
}
