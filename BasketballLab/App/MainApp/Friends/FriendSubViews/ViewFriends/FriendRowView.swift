//
//  FriendRowView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/7/24.
//

import SwiftUI

struct FriendRowView: View {
    
    let user : User
    
    var body: some View {
        
       // Text(user.username)
        VStack {
            HStack {
                Text(String(user.username.first!.uppercased()))
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color(.systemGray))
                    .clipShape(Circle())//.padding(.horizontal)
                    .padding(.leading, 20)
                
                VStack {
                    HStack {
                        
                        Text(user.username).padding(.leading, 20)
                        
                    }
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Last trained x units ago").font(.caption)
                        Spacer()
                    }
                }.padding(.top, 10)
                Spacer()
            }
        }
    }
}

#Preview {
    FriendRowView(user: User(id: "soine", username: "moe", email: "soieng@gmail.com"))
}
