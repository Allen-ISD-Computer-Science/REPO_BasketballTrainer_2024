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

class DribbleDetectorDelegate : NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var cameraViewModel : CameraViewModel?
    
    var requests = [VNRequest]()
    var frameBuffer = FrameBuffer(maxLength: 60)
    
    override init() {
        super.init()
        Task {
            let modelURL = Bundle.main.url(forResource: "best", withExtension: "mlmodelc")
            
            do {
                let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL!))
                let recognitions = VNCoreMLRequest(model: visionModel, completionHandler: detectionDidComplete)
                self.requests = [recognitions]
            } catch let error {
                print(error)
            }
            print("initialized detector")
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {print("unable to make buffer");return}
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .down, options: [:])
        
        do {
            try imageRequestHandler.perform(self.requests)
        } catch let error {
            print(error)
        }
        
    }
    
    
    
    func detectionDidComplete(request: VNRequest, error: Error?) {
        DispatchQueue.main.async(execute: {
            if let results = request.results {
                self.plotDetections(results)
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
               // VisionCalculations.dribbleDetection(frameBuffer: self.frameBuffer)
            }
        })
    }
    
    func plotDetections(_ results: [VNObservation]) {
        if let viewModel = self.cameraViewModel {
        
            viewModel.cameraView.view.layer.sublayers = nil
            
            for observation in results where observation is VNRecognizedObjectObservation {
                guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue }
                
                // Transformations
                let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(UIScreen.main.bounds.size.width), Int(UIScreen.main.bounds.size.height))
                
                let transformedBounds = CGRect(x: objectBounds.minX, y: UIScreen.main.bounds.size.height - objectBounds.maxY, width: objectBounds.maxX - objectBounds.minX, height: objectBounds.maxY - objectBounds.minY)
                
                let boxLayer = self.drawBoundingBox(transformedBounds)

                viewModel.cameraView.view.layer.addSublayer(boxLayer)
                print(viewModel.cameraView.view)
                print(viewModel.cameraView.view.subviews)
            }
        }
    }
    
    func drawBoundingBox(_ bounds: CGRect) -> CALayer {
        let boxLayer = CALayer()
        boxLayer.frame = bounds
        boxLayer.borderWidth = 3.0
        boxLayer.borderColor = CGColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        boxLayer.cornerRadius = 4
        return boxLayer
    }

    
    
    
}
