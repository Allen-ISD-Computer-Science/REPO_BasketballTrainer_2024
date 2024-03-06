//
//  AddFriendView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/4/24.
//

import SwiftUI

struct AddFriendView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    @State private var friendName = ""
    
    var body: some View {
        
        
        ScrollView {
            
        VStack(spacing: 30) {
            Spacer().frame(height: 30)
            
            InputView(text: $friendName, title: "Username", placeholder: "Enter the username of the user").padding(.bottom, 30)
            
            
            Button {
                Task {
                    await authViewModel.sendFriendRequest(username: friendName)
                }
            } label : {
                
                ButtonView(text: "Add Friend", imageName: "person.fill.badge.plus")
                    .background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                    .padding(.top, 0)
                    .alert(authViewModel.errorMessage ?? "", isPresented: $authViewModel.alertShowing) { Button("OK", role: .cancel) { } }
            }.disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.6)
            
            
            Text("Any user you send a request will not be visible in your friends list until they accept your friend request.").padding(.horizontal, 40)
                .frame(alignment: .center)
                .padding(.top, 30)
            Spacer()
        }.onTapGesture { hideKeyboard() }
    }
    }
}

//https://forums.developer.apple.com/forums/thread/738726 weird nan
//https://forums.developer.apple.com/forums/thread/730213 gesture timeout

extension AddFriendView : AuthenticationFormProtocol {
    var formIsValid : Bool {
        return !friendName.isEmpty
    }
}

#Preview {
    AddFriendView().environmentObject(AuthViewModel())
}
