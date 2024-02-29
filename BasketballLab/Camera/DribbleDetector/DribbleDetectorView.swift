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
    @StateObject var dribbleDetectorDelegate = DribbleDetectorDelegate()
    @State var trainingSession = DribbleSession()
    
    var body : some View {
        
            ZStack {
                cameraViewModel.cameraView.ignoresSafeArea()
                VStack {
                    Spacer()
                    
                    
                    NavigationLink(destination: DribbleSessionView(trainingSession: trainingSession)) {
                        ButtonView(text: "End Session", imageName: "xmark", widthProportion: 0.75).background(Color.red).foregroundColor(.white).cornerRadius(10)
                    }
                    
                    
                    
                    
                    //Spacer().frame(maxWidth: .infinity, maxHeight: 40).border(.green)
                }
            }
        
        
            .onDisappear {
                cameraViewModel.viewData.previewObservation = nil
                cameraViewModel.captureSession.stopRunning()
                print("stopped running")
            }
            .onAppear() { dribbleDetectorDelegate.cameraViewModel = cameraViewModel; print("set viewmodel for delegate")}
            .task {
                print(cameraViewModel.configured)
                await cameraViewModel.getAuthorization()
                if cameraViewModel.configured == true {
                    cameraViewModel.setDelegate(delegate: dribbleDetectorDelegate)
                    cameraViewModel.startCamera()
                }
                
            
        }
    }
}
    
    

