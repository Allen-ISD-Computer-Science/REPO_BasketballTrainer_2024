//
//  ProfileSettingsView.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import SwiftUI

struct ProfileSettingsView: View {
    var body: some View {
        
        var name = "Onik Hoque"
        var email = "onikh738@gmail.com"
        var versionNumber = "1.0.0"
        
        List {
            Section {
                HStack {
                    Text(User.mockUser.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(name)
                        Text(email).accentColor(.gray)
                    }.padding([.leading], 10)
                }
            }
            
            Section("general") {
                
                HStack {
                    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color.gray)
                    Spacer()
                    Text(versionNumber).padding([.trailing], 10)
                }
            }
            
            Section("account") {
                
                Button {
                    print("signed out")
                } label : {
                    SettingsRowView(imageName: "arrow.left", title: "Sign Out", tintColor: Color.gray)
                }
                
                Button {
                    print("signed out")
                } label : {
                    SettingsRowView(imageName: "trash", title: "Delete Account", tintColor: Color.red)
                }
                
            }
        }
        
        
    }
}

#Preview {
    ProfileSettingsView()
}
