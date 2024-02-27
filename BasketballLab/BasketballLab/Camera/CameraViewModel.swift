//
//  ViewData.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/23/24.
//

import Foundation
import SwiftUI
import Observation
import AVFoundation
import Vision
import CoreML

class ViewData {
    var captureDevice : AVCaptureDevice?
    var captureSession : AVCaptureSession?
    var output : AVCaptureVideoDataOutput?
    var rotationCoordinator : AVCaptureDevice.RotationCoordinator?
    var previewObservation : NSKeyValueObservation?
}


@Observable class CameraViewModel : NSObject {
    
    var picture : UIImage?
    var requests = [VNRequest]()
    
    
    @ObservationIgnored var cameraView : CameraPreviewView!
    @ObservationIgnored var viewData : ViewData!
    
    override init() {
        cameraView = CameraPreviewView()
        viewData = ViewData()
        
    }
    
    func getAuthorization() async {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        await MainActor.run {
            if granted {
                self.prepareCamera()
                self.setupDetector()
            } else {
                print("not authorized")
            }
        }
    }
    
    func prepareCamera() {
        
        viewData.captureSession = AVCaptureSession()
        viewData.captureSession?.beginConfiguration()
        viewData.captureSession?.sessionPreset = .vga640x480
        viewData.captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        if let _ = try? viewData.captureDevice?.lockForConfiguration() {
            viewData.captureDevice?.isSubjectAreaChangeMonitoringEnabled = true
            viewData.captureDevice?.unlockForConfiguration()
        }
        
        if let device = viewData.captureDevice {
            if let input = try? AVCaptureDeviceInput(device: device) {
                viewData.captureSession?.addInput(input)
                
                viewData.output = AVCaptureVideoDataOutput()
                if (viewData.output != nil) {
                    viewData.captureSession?.addOutput(viewData.output!)
                    viewData.output?.alwaysDiscardsLateVideoFrames = true
                    viewData.output?.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
                    viewData.output?.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
                }
                viewData.captureSession?.commitConfiguration()
                showCamera()
            } else {
                print("Not authorized1")
            }
        } else {
            print("Not authorized2")
        }
    }
    
    
    
    func showCamera() {
        let previewLayer = cameraView.view.layer as? AVCaptureVideoPreviewLayer
        previewLayer?.session = viewData.captureSession
        
        if let device = viewData.captureDevice, let preview = previewLayer {
            viewData.rotationCoordinator = AVCaptureDevice.RotationCoordinator(device: device, previewLayer: preview)
            preview.connection?.videoRotationAngle = viewData.rotationCoordinator!.videoRotationAngleForHorizonLevelPreview
            viewData.previewObservation = viewData.rotationCoordinator!.observe(\.videoRotationAngleForHorizonLevelPreview, changeHandler: { old, value in
                preview.connection?.videoRotationAngle = self.viewData.rotationCoordinator!.videoRotationAngleForHorizonLevelPreview
            })
        }
        Task(priority: .background) {
            viewData.captureSession?.startRunning()
            print("began running capture session")
        }
    }
}

extension CameraViewModel : AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {print("unable to make buffer");return}
        
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        
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
                for observation in results where observation is VNRecognizedObjectObservation {
                    guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue}
                    print(objectObservation.boundingBox.maxY)
                }
            }
        })
    }
    
    
}
