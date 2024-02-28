//
//  CustomCameraView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/23/24.
//

import Foundation
import AVFoundation
import SwiftUI

struct DribbleDetectorView : View {
    
    @Bindable var cameraViewModel : CameraViewModel
    
   
    
    var body : some View {
        
        ZStack {
            cameraViewModel.cameraView.ignoresSafeArea()
            VStack {
                Spacer()
                Button("End Session") {
                }.frame(width: 200, height: 60)
                    .background(Color.red)
                    .cornerRadius(10.0)
                    .foregroundColor(Color.white)
                Spacer().frame(maxWidth: .infinity, maxHeight: 40).border(.green)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {} //cameraViewModel.showCamera() }
        .task {
            await cameraViewModel.getAuthorization()
            if cameraViewModel.configured == true {
                cameraViewModel.showCamera()
            }
        }
        .onDisappear {
            cameraViewModel.viewData.previewObservation = nil
            cameraViewModel.captureSession.stopRunning()
            print("stopped running")
        }
    }
    
    
}
