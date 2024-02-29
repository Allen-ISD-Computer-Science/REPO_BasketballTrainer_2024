//
//  CameraView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/21/24.
//

import SwiftUI

struct WorkoutsView: View {
    
    private var cameraViewModel = CameraViewModel()
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            
            NavigationLink("Dribble Detection Drill") {
                DribbleDetectorView(cameraViewModel: cameraViewModel)//.toolbar(.hidden, for: .tabBar)
            }
            
            NavigationLink("Test") {
                Text("g").onAppear {
                    print(navigationPath.count)
                }
            }
            
        }
        
    }
}

#Preview {
    WorkoutsView()
   // Text("replace later")
}
