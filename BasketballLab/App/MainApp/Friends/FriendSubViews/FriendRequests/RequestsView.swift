//
//  RequestsView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/6/24.
//

import SwiftUI

struct RequestsView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        VStack {
            
            if let outgoingRequests = authViewModel.outgoingRequests, let receivedRequests = authViewModel.receivedRequests {

                    List {
                        
                        
                        
                        Section("Incoming Requests") {
                            if !receivedRequests.isEmpty {
                                ForEach(receivedRequests) { user in
                                    ReceivedRequestView(user: user)
                                }
                            } else {
                                Text("No incoming friend requests").padding()
                            }
                         }
                        
                        Section("Outgoing Requests") {
                            if !outgoingRequests.isEmpty {
                                ForEach(outgoingRequests) { miniUser in
                                    OutgoingRequestView(user: miniUser)
                                }
                            } else {
                                Text("No outgoing friend requests").padding()
                            }
                        }
                        
                        
                    }.listStyle(.plain)
                
            } else {

                Spacer()
                ProgressView()
                Spacer()
                
            }
        }.onAppear {
            Task {
                try await authViewModel.fetchFriends()
            }
        }
    }
}


#Preview {
    RequestsView()
}
