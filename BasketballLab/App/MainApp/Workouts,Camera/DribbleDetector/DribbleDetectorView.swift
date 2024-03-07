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
    @Binding var rotateToPortrait : Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body : some View {
        
            ZStack {
                
                cameraViewModel.cameraView.ignoresSafeArea()
                
                VStack {
                    
                    
                    HStack {
                        Button {
                            print("before")
                            dismiss()
                            print("after")
                        } label : {
                            Image(systemName: "xmark")
                              .foregroundColor(.white)
                              .padding() // Add padding for aesthetics (optional)
                              .background(
                                Circle()
                                  .fill(Color.red) // Change background color if needed
                              ).padding()
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: DribbleSessionView(trainingSession: $dribbleDetectorDelegate.trainingSession)) {
                            ButtonView(text: "End Session", imageName: "xmark").background(Color.red).foregroundColor(.white).cornerRadius(10)
                        }.simultaneousGesture(TapGesture().onEnded {
                            dribbleDetectorDelegate.trainingSession.endDate = Date.now
                          })
                    
                }
                
              
            }
            .onDisappear {
                cameraViewModel.viewData.previewObservation = nil
                cameraViewModel.captureSession.stopRunning()
                dribbleDetectorDelegate.destroySession()
                print("stopped running")
                rotateToPortrait = true
            }
            .onAppear() {
                dribbleDetectorDelegate.cameraViewModel = cameraViewModel;
                dribbleDetectorDelegate.setUpSession()
                if #available(iOS 16.0, *) {
                    guard
                        let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene,
                        let rootViewController = windowScene.windows.first?.rootViewController
                    else { return }

                    rootViewController.setNeedsUpdateOfSupportedInterfaceOrientations()
                    windowScene.requestGeometryUpdate(.iOS(
                        interfaceOrientations: windowScene.interfaceOrientation.isLandscape
                            ? .portrait
                            : .landscapeRight
                    ))
                }
                AppDelegate.orientationLock = .landscapeRight
            }
            .task {
                print("is cameraviewmodel configured?" + String(cameraViewModel.configured))
                await cameraViewModel.getAuthorization()
                if cameraViewModel.configured == true {
                    cameraViewModel.setDelegate(delegate: dribbleDetectorDelegate)
                    cameraViewModel.startCamera()
                }
                
            
        }
    }
}
    
    

