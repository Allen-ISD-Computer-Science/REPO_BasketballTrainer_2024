//
//  CameraView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/21/24.
//

import SwiftUI

struct WorkoutsView: View {
    
    private var cameraViewModel = CameraViewModel()
    //@State var navigationPath = NavigationPath()
    @State var rotateToPortrait = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                ScrollView {
                    VStack {
                        NavigationLink {
                            DribbleDetectorView(cameraViewModel: cameraViewModel).toolbar(.hidden, for: .tabBar).navigationBarBackButtonHidden(true)
                        } label : {
                            DrillSelectorView(title: "Dribble", description: "Count dribbles per session and see workout intensity over time")
                           // Text("test")
                        }
                        
                       /* NavigationLink {
                            DribbleDetectorView(cameraViewModel: cameraViewModel, rotateToPortrait: $rotateToPortrait).toolbar(.hidden, for: .tabBar).navigationBarBackButtonHidden(true)
                        } label : {
                            DrillSelectorView(title: "Dribble", description: "Count dribbles per session and see workout intensity over time", imageName: "dribble")
                        }
                        
                        NavigationLink {
                            DribbleDetectorView(cameraViewModel: cameraViewModel, rotateToPortrait: $rotateToPortrait).toolbar(.hidden, for: .tabBar).navigationBarBackButtonHidden(true)
                        } label : {
                            DrillSelectorView(title: "Dribble", description: "Count dribbles per session and see workout intensity over time", imageName: "dribble")
                        } */
                        
                        Spacer()
                    }.frame(maxWidth: .infinity)
                        .onAppear() {

                    }
                }
            }.navigationTitle("Workouts")
            

        }

        
    }
}

#Preview {
    WorkoutsView()
   // Text("replace later")
}
