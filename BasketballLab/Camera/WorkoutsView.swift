//
//  CameraView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/21/24.
//

import SwiftUI

struct WorkoutsView: View {
    
    private var cameraViewModel = CameraViewModel()
    
    var body: some View {
        
        NavigationStack() {
            NavigationLink("String") {
                DribbleDetectorView(cameraViewModel: cameraViewModel).toolbar(.hidden, for: .tabBar)
            }
        }
        
    }
}

#Preview {
    WorkoutsView()
   // Text("replace later")
}
