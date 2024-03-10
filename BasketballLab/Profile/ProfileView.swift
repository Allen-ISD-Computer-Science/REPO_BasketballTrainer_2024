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
                
                
                
                if let user = authViewModel.currentUser {
                    HStack {
                        Text("Hi, " + user.username)
                            .font(.largeTitle)
                            .bold()
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .frame(alignment: .trailing)
                            .padding(.leading, 18).padding([.bottom], 0)
                        
                        Spacer()
                        
                        NavigationLink {
                          ProfileSettingsView()
                        } label: {
                          Image(systemName: "gear")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                                .padding(.trailing)
                        }
                    }.padding(.bottom, 10).padding(.top, 45).padding(.trailing, 10)
                    
                    
                    Divider()
                    
                    Section(header: Text("Lifetime Efficiency")) {
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
}

#Preview {
    ProfileView()
}
