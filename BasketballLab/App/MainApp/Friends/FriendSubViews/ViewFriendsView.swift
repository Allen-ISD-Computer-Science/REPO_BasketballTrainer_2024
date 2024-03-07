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
        
        if let friends = authViewModel.friends {
            if !friends.isEmpty {
                ForEach(friends) { user in
                    ReceivedRequestView(user: user)
                }
            } else {
                List {
                    Text("No friends to display. ")
                }
            }
        } else {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
    
}

#Preview {
    ViewFriendsView()
}


