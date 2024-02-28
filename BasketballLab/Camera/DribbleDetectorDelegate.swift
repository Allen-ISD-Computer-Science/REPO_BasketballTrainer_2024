//
//  DribbleDetectorDelegate.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/27/24.
//

import Foundation
import Vision
import UIKit
import AVFoundation

class DribbleDetectorDelegate : NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var requests = [VNRequest]()
    var frameBuffer = FrameBuffer(maxLength: 60)
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {print("unable to make buffer");return}
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .down, options: [:])
        
        do {
            try imageRequestHandler.perform(self.requests)
        } catch let error {
            print(error)
        }
        
    }
    
    
    func setupDetector() { //sets up the model
        let modelURL = Bundle.main.url(forResource: "best", withExtension: "mlmodelc")
        
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL!))
            let recognitions = VNCoreMLRequest(model: visionModel, completionHandler: detectionDidComplete)
            self.requests = [recognitions]
        } catch let error {
            print(error)
        }
    }
    
    
    func detectionDidComplete(request: VNRequest, error: Error?) {
        DispatchQueue.main.async(execute: {
            if let results = request.results {
                let ball = results.first as? VNRecognizedObjectObservation
                
                if ball != nil {
                    self.frameBuffer.addLocationFrame(frame: Frame(ball: Ball(
                        x1: 1,
                        y1: Int(UIScreen.main.bounds.width*(ball?.boundingBox.minY)!),
                        x2: 1,
                        y2: 1)))
                    print(Int(UIScreen.main.bounds.width*(ball?.boundingBox.minY)!))
                } else {
                    self.frameBuffer.addLocationFrame(frame: Frame(ball: nil))
                }
                VisionCalculations.dribbleDetection(frameBuffer: self.frameBuffer)
            }
        })
    }
    
    
    
}
