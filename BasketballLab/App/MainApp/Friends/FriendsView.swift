//
//  FriendsView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/4/24.
//

import SwiftUI
import SlidingTabView

struct FriendsView: View {
    @State var tabIndex = 0
    
    
    var body: some View {
        
        VStack {
            
            SlidingTabView(selection: $tabIndex, tabs: ["Friends", "Requests", "Add Friend"]).padding(.top, 60)
            
            
            switch tabIndex {
            case 0:
                Text("0")
            case 1:
                Text("1")
            case 2:
                AddFriendView()
            default:
                Text("d")
            }
            
            Spacer()
        }
        
    }
}

#Preview {
    FriendsView()
}
