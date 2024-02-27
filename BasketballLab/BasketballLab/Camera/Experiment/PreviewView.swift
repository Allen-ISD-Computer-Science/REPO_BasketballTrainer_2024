//
//  PreviewView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/22/24.
//

import Foundation
import AVFoundation
import UIKit

class PreviewView : UIView {
    
    override class var layerClass : AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer : AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    
}
