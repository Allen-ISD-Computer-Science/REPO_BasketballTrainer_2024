//
//  AuthViewModelFriendExtension.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/4/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


extension AuthViewModel {
    

    
    func sendFriendRequest(username: String) async {
        do {
            let db = Firestore.firestore()
            let recipientDocuments = try await db.collection("users").whereField("username", isEqualTo: username).getDocuments()
            if username == self.currentUser?.username {
                self.errorMessage = "Cannot add yourself as a friend"
                self.alertShowing = true
                return
            } else if recipientDocuments.isEmpty { //check if the user they want to request exists
                self.errorMessage = "Could not find user with username " + username
                self.alertShowing = true
                return
            } 
            
            let recipientData = recipientDocuments.documents.first!
            let recipientID = recipientData.get("id") as! String
            
            
            let friends = recipientData.get("friends") as! [String]
            let outgoingRequests = recipientData.get("outgoingRequests") as! [String]
            let receivedRequests = recipientData.get("receivedRequests") as! [String]
            
            guard let senderID = self.currentUser?.id else {self.errorMessage = "couldnt get id of current user";self.alertShowing = true;return}
            
            let senderDoc = db.collection("users").document(senderID)
            let recipientDoc = db.collection("users").document(recipientID)
            
            if friends.contains(senderID) {
                self.errorMessage = "You're already friends with this user."
                self.alertShowing = true
                return
            } else if receivedRequests.contains(senderID) {
                self.errorMessage = "You've already sent a request to this user"
                self.alertShowing = true
                return
            } else if outgoingRequests.contains(senderID) {
                self.errorMessage = "This user has sent you a request. To become friends, accept their request."
                self.alertShowing = true
                return
            }
            
            
            try await senderDoc.updateData([
                "outgoingRequests" : FieldValue.arrayUnion([recipientID])
            ])
            try await recipientDoc.updateData([
                "receivedRequests" : FieldValue.arrayUnion([senderID])
            ])
            
            self.errorMessage = "Succesfully sent request to " + username + "!"
            self.alertShowing = true
            
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func getFriends() async {
        
    }
    
    
    
}
