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

    
    @Environment(\.dismiss) var dismiss
    
    var body : some View {
        
            ZStack {
                
                    cameraViewModel.cameraView
                        .ignoresSafeArea()
                
                VStack {
                    
                    
                    HStack {
                        Button {
                            print("before")
                            dismiss()
                            print("after")
                        } label : {
                            Image(systemName: "xmark").foregroundColor(.white).padding().background(Circle().fill(Color.red)).padding()
                        }
                        Spacer()
                    }
                    
                    Spacer().onAppear {
                        let errorHandler: (Error) -> Void = { error in
                            print("An error occurred: \(error)")
                        }
                        if #available(iOS 16.0, *) {
                                guard
                                    let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController,
                                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                                else { return }
                                rootViewController.setNeedsUpdateOfSupportedInterfaceOrientations()
                                windowScene.requestGeometryUpdate(.iOS(
                                    interfaceOrientations: windowScene.interfaceOrientation.isLandscape
                                        ? .portrait
                                        : .landscapeRight
                                ))
                            } else {
                               // UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
                            }
                        
 
                          
                          
                          
                    }
                    
                    NavigationLink(destination: DribbleSessionView(trainingSession: $dribbleDetectorDelegate.trainingSession)) {
                            ButtonView(text: "End Session", imageName: "xmark").background(Color.red).foregroundColor(.white).cornerRadius(10)
                        }.simultaneousGesture(TapGesture().onEnded {
                            dribbleDetectorDelegate.trainingSession.endDate = Date.now
                          })
                    
                }
                
              
            }
            .onDisappear {
                print("onDisappear dribble detector ran")
                cameraViewModel.viewData.previewObservation = nil
                cameraViewModel.captureSession.stopRunning()
                dribbleDetectorDelegate.destroySession()
               // print("stopped running")
            }
            .onAppear() {
                print("onAppear dribble detector ran whole")
                dribbleDetectorDelegate.cameraViewModel = cameraViewModel;
                dribbleDetectorDelegate.setUpSession()
                

                
            }
            .task {
                await cameraViewModel.getAuthorization()
                if cameraViewModel.configured == true {
                    cameraViewModel.setDelegate(delegate: dribbleDetectorDelegate)
                    cameraViewModel.startCamera()
                }
                
            
        }
    }
}
    
    

