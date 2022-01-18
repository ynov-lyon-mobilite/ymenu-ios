//
//  ARQuickLook.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 29/01/2021.
//

import UIKit
import QuickLook
import ARKit

class ARQuickLookViewController: UIViewController, QLPreviewControllerDataSource {

    var filePath: String
    let previewController = QLPreviewController()
    var presented: Bool = true
    var rootView: ARQLView
    
    init(filePath: String, isPresented: Bool, rootView: ARQLView){
        self.filePath = filePath
        self.presented = isPresented
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.previewController.dataSource = self
        if presented {
            present(self.previewController, animated: true, completion: nil)
            presented = false
        } else {
            self.previewController.dismiss(animated: true)
            self.dismiss(animated: true)
        }
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let item = ARQuickLookPreviewItem(fileAt: URL(string: filePath)!)
            item.allowsContentScaling = false
        return item
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.rootView.dismiss()
        self.presented = false
    }

}
