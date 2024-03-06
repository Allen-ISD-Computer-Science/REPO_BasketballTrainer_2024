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
    @State var rotateToPortrait = false
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            
            NavigationLink("Dribble Detection Drill") {
                DribbleDetectorView(cameraViewModel: cameraViewModel, rotateToPortrait: $rotateToPortrait).toolbar(.hidden, for: .tabBar).navigationBarBackButtonHidden(true)
            }
            
            NavigationLink("Test") {
                Text("g").onAppear {
                    print(navigationPath.count)
                }
            }
            
            if rotateToPortrait == true {
                Text("test").onAppear {
                    print("your bullshit worked")
                    rotateToPortrait = false
                }
            }
            
        }.onAppear() {
            AppDelegate.orientationLock = .allButUpsideDown
            
            if UIDevice.current.orientation.isPortrait {
                let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene
                windowScene?.requestGeometryUpdate(.iOS(
                    interfaceOrientations: .portrait
                ))
            }
        }
        
    }
}

#Preview {
    WorkoutsView()
   // Text("replace later")
}
