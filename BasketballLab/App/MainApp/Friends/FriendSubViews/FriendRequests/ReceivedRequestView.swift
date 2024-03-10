//
//  MiniUserView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/6/24.
//

import SwiftUI

struct ReceivedRequestView: View {
    
    let user : User
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(String(user.username.first!.uppercased()))
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 45, height: 45)
                    .background(Color(.systemGray))
                    .clipShape(Circle())//.padding(.horizontal)
                
                
                Text(user.username).padding(.leading)
                
                
                
                Spacer()
                
                Button {
                    Task {
                        try await authViewModel.acceptFriendRequest(senderID: user.id)
                    }
                } label : {
                    Text("Accept").font(.footnote)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .frame(width: 70, height: 40)
                        .background(Color.blue)
                        .cornerRadius(10)
                }.buttonStyle(.plain)
                
                Button {
                    Task {
                        try await authViewModel.declineFriendRequest(senderID: user.id)
                    }
                } label : {
                    Text("Decline").font(.footnote)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .frame(width: 70, height: 40)
                        .background(Color.red)
                        .cornerRadius(10)
                }.buttonStyle(.plain)
                
            }
          //  Divider()
        }
    }
}

#Preview {
    ReceivedRequestView(user: User(id: "segkjbseg", username: "josh", email: "sfiu@gmail.com"))
}
