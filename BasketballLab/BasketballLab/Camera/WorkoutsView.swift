//
//  CameraView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/21/24.
//

import SwiftUI

struct WorkoutsView: View {
    
    var body: some View {
        
        NavigationStack() {
            NavigationLink("String") {
                CameraView()
            }
        }
        .navigationTitle("Workouts")
    }
}

#Preview {
    WorkoutsView()
   // Text("replace later")
}
