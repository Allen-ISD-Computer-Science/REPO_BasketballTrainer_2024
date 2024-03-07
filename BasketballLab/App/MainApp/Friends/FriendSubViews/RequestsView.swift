//
//  RequestsView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/6/24.
//

import SwiftUI

struct RequestsView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    @State var miniUsers : [MiniUser] = []
    
    var body: some View {
        
        VStack {
            
            if miniUsers.isEmpty {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                
                Section {
                    ForEach(miniUsers) { miniUser in
                        MiniUserView(miniUser: miniUser)
                    }
                }
                
            }
        }.onAppear {
            Task {
                self.miniUsers = try await authViewModel.getOutgoingRequests()
            }
        }
    }
}


#Preview {
    RequestsView()
}
