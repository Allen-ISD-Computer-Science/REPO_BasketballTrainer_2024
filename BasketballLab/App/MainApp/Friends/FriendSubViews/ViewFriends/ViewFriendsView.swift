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
                    
                    List {
                        ForEach(friends) { user in
                            NavigationLink {
                                FriendProfileView(user: user)
                            } label : {
                                FriendRowView(user: user)
                            }
                        }
                       
                    }.listStyle(.plain)
                    
                } else {
                    
                    Text("No friends to display. ")
                    
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
    ViewFriendsView().environmentObject(AuthViewModel())
}


