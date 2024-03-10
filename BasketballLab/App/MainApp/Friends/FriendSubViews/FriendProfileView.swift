//
//  FriendProfileView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/7/24.
//

import SwiftUI

struct FriendProfileView: View {
    
    let user : User
    
    var body: some View {
        
        HStack {
            Text(user.username)
                .font(.largeTitle)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .frame(alignment: .trailing)
                .padding(.leading, 30).padding([.bottom], 0)
            
            Spacer()
        }
        
        Divider()
        
        StatBar(name: "Field Goal Percentage",
                value: 0.547,
                color: Color(.red))
        
        StatBar(name: "Three Point Percentage",
                value: 0.387,
                color: Color(.green))
        
        StatBar(name: "Free Throw",
                value: 0.826,
                color: Color(.blue))
        
        Divider()
    }
}

#Preview {
    Text("")
   // FriendProfileView()
}
