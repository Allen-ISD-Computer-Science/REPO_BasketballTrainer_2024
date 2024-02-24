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

class ViewData {
    var captureDevice : AVCaptureDevice?
    var captureSession : AVCaptureSession?
    var stillImage : AVCapturePhotoOutput?
    var rotationCoordinator : AVCaptureDevice.RotationCoordinator?
    var previewObservation : NSKeyValueObservation?
}


@Observable class CameraViewModel : NSObject, AVCapturePhotoCaptureDelegate {
    
    var path = NavigationPath()
    var picture : UIImage?
    
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
            } else {
                print("not authorized")
            }
        }
    }
    
    func prepareCamera() {
        
        viewData.captureSession = AVCaptureSession()
        viewData.captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        if let _ = try? viewData.captureDevice?.lockForConfiguration() {
            viewData.captureDevice?.isSubjectAreaChangeMonitoringEnabled = true
            viewData.captureDevice?.unlockForConfiguration()
        }
        
        if let device = viewData.captureDevice {
            if let input = try? AVCaptureDeviceInput(device: device) {
                viewData.captureSession?.addInput(input)
                
                viewData.stillImage = AVCapturePhotoOutput()
                if viewData.stillImage != nil {
                    
                    viewData.captureSession?.addOutput(viewData.stillImage!)
                  /*  if let max = viewData.captureDevice?.activeFormat.supportedMaxPhotoDimensions.last {
                        viewData.stillImage?.maxPhotoDimensions = max
                    } */
                    
                }
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
    
    func takePicture() {
        let settings = AVCapturePhotoSettings()
        if let max = viewData.captureDevice?.activeFormat.supportedMaxPhotoDimensions.last {
            settings.maxPhotoDimensions = max
        }
        viewData.stillImage?.capturePhoto(with: settings, delegate: self)
    }
    
    
    private func photoOutput(_ output: AVCaptureOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let scale = scene?.screen.scale ?? 1
        let orientationAngle = viewData.rotationCoordinator!.videoRotationAngleForHorizonLevelCapture
        var imageOrientation : UIImage.Orientation!
        
        switch orientationAngle {
        case 90.0:
            imageOrientation = .right
        case 270.0:
            imageOrientation = .left
        case 0.0:
            imageOrientation = .up
        case 180.0:
            imageOrientation = .down
        default:
            imageOrientation = .right
        }
        
        if let imageData = photo.cgImageRepresentation() {
            picture = UIImage(cgImage: imageData, scale: scale, orientation: imageOrientation)
            path = NavigationPath()
        }
    }
    
    
}
