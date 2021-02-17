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
    var fileName: String
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
        private lazy var fileURL: URL = Bundle.main.url(forResource: parent.fileName,
                                                        withExtension: "reality")!
        init(_ parent: ARQuickLookView) {
            self.parent = parent
            super.init()
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            guard let path = Bundle.main.path(forResource: parent.fileName, ofType: "reality") else { fatalError("Couldn't find the supported input file.") }
                let url = URL(fileURLWithPath: path)
                if #available(iOS 13.0, *) {
                    let item = ARQuickLookPreviewItem(fileAt: url)
                    item.allowsContentScaling = parent.allowScaling
                    item.canonicalWebPageURL = nil
                    return item
                } else { }
                return url as QLPreviewItem
        }

        @objc func dismiss(_ controller: QLPreviewController) {
            parent.isPresented = false
        }
    }
}
