//
//  ContentView.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        Group {
            if authViewModel.userSession != nil {
                MainView()
            } else {
                LoginView()
            }
        }
        
    }
}


#Preview {
    ContentView().environmentObject(AuthViewModel())
}
