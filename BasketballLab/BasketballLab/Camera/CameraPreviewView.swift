//
//  CameraPreviewView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/21/24.
//

import Foundation
import SwiftUI
import AVFoundation

class CameraPreviewUIView : UIView {
    override class var layerClass : AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}

struct CameraPreviewView : UIViewRepresentable {
    let view = CameraPreviewUIView()
    
    func makeUIView(context: Context) -> UIView {
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    
}
