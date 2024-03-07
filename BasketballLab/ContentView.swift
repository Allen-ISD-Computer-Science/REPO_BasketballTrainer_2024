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
                if authViewModel.currentUser != nil {
                    MainView()
                } else {
                    VStack{Spacer();ProgressView();Spacer()}
                }
            } else {
                LoginView()
            }
        }
    }
}


#Preview {
    ContentView().environmentObject(AuthViewModel())
}
