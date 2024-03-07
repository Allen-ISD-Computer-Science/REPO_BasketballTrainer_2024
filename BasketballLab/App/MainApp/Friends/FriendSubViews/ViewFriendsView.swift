//
//  ViewFriendsView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/6/24.
//

import SwiftUI

struct ViewFriendsView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).onAppear {
            Task {
                //try await authViewModel.getFriends()
            }
        }
    }
    
}

#Preview {
    ViewFriendsView()
}
