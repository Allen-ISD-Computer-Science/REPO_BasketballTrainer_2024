//
//  MiniUserView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/6/24.
//

import SwiftUI

struct MiniUserView: View {
    
    var miniUser : MiniUser
    
    var body: some View {
        VStack {
            HStack {
                Text(miniUser.initials)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color(.systemGray))
                    .clipShape(Circle())//.padding(.horizontal)
                
                
                Text(miniUser.username).padding(.horizontal)
                
                
                
                Spacer()
                
                Button {
                    
                } label : {
                    Text("Accept").font(.footnote)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .frame(width: 70, height: 40)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button {
                    
                } label : {
                    Text("Decline").font(.footnote)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .frame(width: 70, height: 40)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
            }.padding(.horizontal)
            Divider()
        }
    }
}

#Preview {
    MiniUserView(miniUser: MiniUser(id: "skeugbkseugb", username: "onikh"))
}
