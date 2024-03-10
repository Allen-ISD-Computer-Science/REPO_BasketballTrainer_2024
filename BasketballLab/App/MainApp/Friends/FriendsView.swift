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
        NavigationStack {
            VStack {
                
                SlidingTabView(selection: $tabIndex, tabs: ["Friends List", "Requests", "Add Friend"])
                
                
                switch tabIndex {
                case 0:
                    ViewFriendsView() //causes ui slowdown. find why
                case 1:
                    RequestsView()
                case 2:
                    AddFriendView()
                default:
                    Text("d")
                }
                
                Spacer()
            }.navigationTitle("Friends")
        }
        
    }
}

#Preview {
    FriendsView()
}
