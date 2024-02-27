//
//  CustomCameraView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/23/24.
//

import Foundation
import AVFoundation
import SwiftUI

struct CameraView : View {
    
    @Environment(CameraViewModel.self) private var appData
    //private var appData = ApplicationData()
    
    var body : some View {
        ZStack {
            appData.cameraView.ignoresSafeArea()
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
        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        //.navigationBarHidden(true)
        .task {
            await appData.getAuthorization()
        }
        .onDisappear {
            appData.viewData.previewObservation = nil
        }
    }
}
