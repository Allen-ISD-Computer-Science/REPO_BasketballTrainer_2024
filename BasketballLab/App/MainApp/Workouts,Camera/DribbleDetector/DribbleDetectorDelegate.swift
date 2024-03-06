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
    var trainingSession = DribbleSession()
    var orientation : CGImagePropertyOrientation = .up
    
    var detectionLayer = CALayer()
    
    func setUpSession() {
        self.frameBuffer = FrameBuffer(maxLength: 60)
        self.trainingSession = DribbleSession()
        
        if cameraViewModel != nil {
            self.cameraViewModel?.cameraView.view.layer.addSublayer(detectionLayer)
            print("added layer")
        } else {
            print("viewmodel is nil!")
        }
        
    }
    
    func destroySession() {
        if let viewModel = self.cameraViewModel {
            if viewModel.cameraView.view.layer.sublayers!.count > 1 {
                for sublayer in 1..<viewModel.cameraView.view.layer.sublayers!.count {
                    viewModel.cameraView.view.layer.sublayers![sublayer].removeFromSuperlayer()
                }
            }
        }
    }
    
    
    
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
        }
        detectionLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func createImageRequestHandler(cvPixelBuffer: CVPixelBuffer, orientation: CGImagePropertyOrientation) -> VNImageRequestHandler {
        return VNImageRequestHandler(cvPixelBuffer: cvPixelBuffer, orientation: orientation, options: [:])
    }
    

    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {print("unable to make buffer");return}
        
        let imageRequestHandler = createImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: self.orientation)
        
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
                let ball = results.first as? VNRecognizedObjectObservation // first object
                
                if ball != nil {
                    let ball = Ball(
                        x: Int(UIScreen.main.bounds.width*(ball?.boundingBox.midX)!),
                        y: Int(UIScreen.main.bounds.width*(ball?.boundingBox.midY)!),
                        height: Int(UIScreen.main.bounds.width*(ball?.boundingBox.height)!))
                    
                    self.frameBuffer.addLocationFrame(frame: Frame(ball: ball))
                    print("X coord: " + String(ball.x) + "   Y coord: " )
                    
                } else {
                    self.frameBuffer.addLocationFrame(frame: Frame(ball: nil))
                }
                if VisionCalculations.dribbleDetection(frameBuffer: self.frameBuffer) {
                    self.trainingSession.dribbles.append(Date.now)
                    print("dribble" + String(self.trainingSession.dribbles.count))
                }
            }
        })
    }
    
    func plotDetections(_ results: [VNObservation]) {
            detectionLayer.sublayers = nil
            for observation in results where observation is VNRecognizedObjectObservation {
                guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue }
                // Transformations
                let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(UIScreen.main.bounds.size.width), Int(UIScreen.main.bounds.size.height))
                let transformedBounds = CGRect(x: objectBounds.minX, y: objectBounds.maxY, width: objectBounds.maxX - objectBounds.minX, height: objectBounds.maxY - objectBounds.minY)
                let boxLayer = self.drawBoundingBox(transformedBounds)
                detectionLayer.addSublayer(boxLayer)
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
