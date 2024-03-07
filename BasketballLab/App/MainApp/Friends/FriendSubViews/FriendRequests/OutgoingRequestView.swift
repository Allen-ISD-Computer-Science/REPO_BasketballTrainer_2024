//
//  OutgoingRequestView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/6/24.
//

import SwiftUI

struct OutgoingRequestView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    var user : User
    
    var body: some View {
        VStack {
            HStack {
                Text(user.initials)
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
                        try await authViewModel.cancelFriendRequest(recipientID: user.id)
                        print("canceled frirnd request attempt")
                    }
                } label : {
                    Text("Cancel").font(.footnote)
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
    OutgoingRequestView(user: User(id: "id", username: "luke", email: "iseng@gmail.com"))
}
