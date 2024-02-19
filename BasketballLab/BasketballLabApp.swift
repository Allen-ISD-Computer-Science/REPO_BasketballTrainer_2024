//
//  BasketballLabApp.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/18/24.
//

import SwiftUI
import Firebase

@main
struct BasketballLabApp: App {
    
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
