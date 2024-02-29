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
    var rotationCoordinator : AVCaptureDevice.RotationCoordinator?
    var previewObservation : NSKeyValueObservation?
}


@Observable class CameraViewModel : NSObject {
    
    var captureSession = AVCaptureSession()
    var output = AVCaptureVideoDataOutput()
    var captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
    
    var requests = [VNRequest]()
    var frameBuffer = FrameBuffer(maxLength: 60)
    
    var configured = false
    
    @ObservationIgnored var cameraView : CameraPreviewView!
    @ObservationIgnored var viewData : ViewData!
    
    override init() {
        cameraView = CameraPreviewView()
        viewData = ViewData()
        print("initialized camera view model")
        
    }
    
    deinit {
        print("deinitialized")
    }
    
    func getAuthorization() async {
        self.setupDetector()
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        await MainActor.run {
            if granted && configured == false {
                self.prepareCamera()
                configured = true
            } else {
                print("not authorized")
            }
        }
    }
    
    func prepareCamera() {
        
        self.captureSession.beginConfiguration()
        self.captureSession.sessionPreset = .iFrame960x540
        
        if let _ = try? self.captureDevice?.lockForConfiguration() {
            self.captureDevice?.isSubjectAreaChangeMonitoringEnabled = true
            self.captureDevice?.unlockForConfiguration()
        }
        
        if let device = self.captureDevice {
            if let input = try? AVCaptureDeviceInput(device: device) {
                self.captureSession.addInput(input)
                self.captureSession.addOutput(self.output)
                self.output.alwaysDiscardsLateVideoFrames = true
                self.output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
                self.output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
                self.captureSession.commitConfiguration()
                print("configured")
            } else {
                print("Not authorized1")
            }
        } else {
            print("Not authorized2")
        }
        
        let previewLayer = cameraView.view.layer as? AVCaptureVideoPreviewLayer
        previewLayer?.zPosition = 0
        previewLayer?.session = self.captureSession
        
        if let device = self.captureDevice, let preview = previewLayer {
            viewData.rotationCoordinator = AVCaptureDevice.RotationCoordinator(device: device, previewLayer: preview)
            preview.connection?.videoRotationAngle = viewData.rotationCoordinator!.videoRotationAngleForHorizonLevelPreview
            viewData.previewObservation = viewData.rotationCoordinator!.observe(\.videoRotationAngleForHorizonLevelPreview, changeHandler: { old, value in
                preview.connection?.videoRotationAngle = self.viewData.rotationCoordinator!.videoRotationAngleForHorizonLevelPreview
            })
        }
    }
    
    
    
    func startCamera() {
        Task(priority: .background) {
            
            self.captureSession.startRunning()
            print("began running capture session")
        }
    }
    
    func setDelegate(delegate: some AVCaptureVideoDataOutputSampleBufferDelegate) {
        if self.captureSession.isRunning {
            captureSession.stopRunning()
        }
        self.captureSession.beginConfiguration()
        self.output.setSampleBufferDelegate(delegate, queue: DispatchQueue(label: "com.yourApp.sampleBufferDelegate"))
        self.captureSession.commitConfiguration()
        print("delegate set")
    }
}


extension CameraViewModel : AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("error")
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
