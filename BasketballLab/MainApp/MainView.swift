//
//  MainView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/18/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        TabView {
            
            ProfileView()
                .tabItem {
                    Label("My Profile", systemImage: "person.crop.square.filled.and.at.rectangle")
                }
            
            Text("workout")
                .tabItem {
                    Label("Workouts", systemImage: "basketball")
                }
            
            Text("Placeholder")
                .tabItem {
                    Label("Friends", systemImage: "figure.2")
                        .font(.caption2)
                }
        }
        
    }
}

#Preview {
    MainView()
}
