//
//  ProfileView.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                HStack {
                    Spacer()
                    NavigationLink {
                      ProfileSettingsView()
                    } label: {
                      Image(systemName: "gear")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .padding(.trailing)
                    }
                }.padding(.bottom, 10).padding([.top, .trailing], 20)
                
                
                if let user = authViewModel.currentUser {
                    HStack {
                        Text("Hi, " + user.username)
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
        }
    }
}

#Preview {
    ProfileView()
}
