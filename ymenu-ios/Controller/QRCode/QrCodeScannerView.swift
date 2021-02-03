//
//  QrCodeScannerView.swift
//  ymenu-ios
//
//  Created by Enzo Sborea on 25/11/2020.
//

import SwiftUI
import UIKit
import AVFoundation

struct QrCodeScannerView: UIViewRepresentable {
    @ObservedObject var viewModel = QrCodeScannerViewModel()
    
    var supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]
    typealias UIViewType = CameraPreview
    
    private let session = AVCaptureSession()
    private let delegate = QrCodeCameraDelegate()
    private let metadataOutput = AVCaptureMetadataOutput()
    
    
    func torchLight(isOn: Bool) -> QrCodeScannerView {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if backCamera.hasTorch {
                try? backCamera.lockForConfiguration()
                if isOn {
                    backCamera.torchMode = .on
                } else {
                    backCamera.torchMode = .off
                }
                backCamera.unlockForConfiguration()
            }
        }
        return self
    }
    
    func interval(delay: Double) -> QrCodeScannerView {
        delegate.scanInterval = delay
        return self
    }
    
    func found(r: @escaping (String) -> Void) -> QrCodeScannerView {
        delegate.onResult = r
        return self
    }
    
    func simulator(mockBarCode: String)-> QrCodeScannerView{
        delegate.mockData = mockBarCode
        return self
    }
    
    func setupCamera(_ uiView: CameraPreview) {
        if !viewModel.isReload {
            if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
                if let input = try? AVCaptureDeviceInput(device: backCamera) {
                    session.sessionPreset = .photo
                    
                    if session.canAddInput(input) {
                        session.addInput(input)
                    }
                    if session.canAddOutput(metadataOutput) {
                        session.addOutput(metadataOutput)
                        
                        metadataOutput.metadataObjectTypes = supportedBarcodeTypes
                        metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                    }
                    let previewLayer = AVCaptureVideoPreviewLayer(session: session)
                    
                    uiView.backgroundColor = UIColor.gray
                    previewLayer.videoGravity = .resizeAspectFill
                    uiView.layer.addSublayer(previewLayer)
                    uiView.previewLayer = previewLayer
                    
                    session.startRunning()
                }
            }
            
            viewModel.setReload()
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<QrCodeScannerView>) -> QrCodeScannerView.UIViewType {
        let cameraView = CameraPreview(session: session)
        
        #if targetEnvironment(simulator)
        cameraView.createSimulatorView(delegate: self.delegate)
        #else
        checkCameraAuthorizationStatus(cameraView)
        #endif
        
        return cameraView
    }
    
    func updateUIView(_ uiView: QrCodeScannerView.UIViewType, context: UIViewRepresentableContext<QrCodeScannerView>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        #if targetEnvironment(simulator)
        uiView.createSimulatorView(delegate: self.delegate)
        #else
        setupCamera(uiView)
        #endif
    }
    
    static func dismantleUIView(_ uiView: CameraPreview, coordinator: ()) {
        uiView.session.stopRunning()
    }
    
    private func checkCameraAuthorizationStatus(_ uiView: CameraPreview) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if cameraAuthorizationStatus == .authorized {
            setupCamera(uiView)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.sync {
                    if granted {
                        self.setupCamera(uiView)
                    }
                }
            }
        }
    }
}