//
//  ProfileSettingsView.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import SwiftUI

struct ProfileSettingsView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        
        if let user = authViewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(user.fullName)
                            Text(user.email).accentColor(.gray)
                        }.padding([.leading], 10)
                    }
                }
                
                Section("general") {
                    
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color.gray)
                        Spacer()
                        Text(BasketballLab.version).padding([.trailing], 10)
                    }
                }
                
                Section("account") {
                    
                    Button {
                        authViewModel.signOut()
                    } label : {
                        SettingsRowView(imageName: "arrow.left", title: "Sign Out", tintColor: Color.gray)
                    }
                    
                    Button {
                        Task {
                            try await authViewModel.deleteAccount()
                        }
                    } label : {
                        SettingsRowView(imageName: "trash", title: "Delete Account", tintColor: Color.red)
                    }
                    
                }
            
        }
            
        } else {
            Text("Unable to display user details. Relaunch and sign in.")
        }
        
        
        
    }
}

#Preview {
    ProfileSettingsView().environmentObject(AuthViewModel())
}
