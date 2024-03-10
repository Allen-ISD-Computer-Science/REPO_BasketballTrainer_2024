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
            
            guard let senderID = self.currentUser?.id else {self.errorMessage = "sendFriendRequest: couldnt get id of current user";self.alertShowing = true;return}
            
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
            try await fetchOutgoingRequests()
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func fetchFriends() async throws {
        var users : [User] = []
        do {
            
            let db = Firestore.firestore()
            guard let senderID = self.currentUser?.id else {print("fetchFriends: couldnt get id of current user");self.errorMessage = "fetchFriends: couldnt get id of current auser";self.alertShowing = true;return}
            
            let userDoc = db.collection("users").document(senderID)
            let userSnapshot = try await userDoc.getDocument()
            let requestIDs = userSnapshot.get("friends") as! [String]
            
            print(requestIDs)
            
            for id in requestIDs {
                let userDoc = db.collection("users").document(id)
                let userSnapshot = try await userDoc.getDocument()
                let user = try userSnapshot.data(as: User.self)
                
                users.append(user)
                print("friend" + user.id)
            }

        } catch {
            print(error.localizedDescription)
        }
        self.friends = users
    }
    
    func fetchOutgoingRequests() async throws {
        var users : [User] = []
        do {
            
            let db = Firestore.firestore()
            guard let senderID = self.currentUser?.id else {self.errorMessage = "fetchOutgoingRequests: couldnt get id of current user";self.alertShowing = true;return}
            
            let userDoc = db.collection("users").document(senderID)
            let userSnapshot = try await userDoc.getDocument()
            let requestIDs = userSnapshot.get("outgoingRequests") as! [String]
            
            print(requestIDs)
            
            for id in requestIDs {
                let userDoc = db.collection("users").document(id)
                let userSnapshot = try await userDoc.getDocument()
                let user = try userSnapshot.data(as: User.self)
                
                users.append(user)
            }

        } catch {
            print(error.localizedDescription)
        }
        self.outgoingRequests = users
    }
    
    func fetchReceivedRequests() async throws {
        var users : [User] = []
        do {
            
            let db = Firestore.firestore()
            guard let senderID = self.currentUser?.id else {self.errorMessage = "fetchReceivedRequests: couldnt get id of current user";self.alertShowing = true;return}
            
            let userDoc = db.collection("users").document(senderID)
            let userSnapshot = try await userDoc.getDocument()
            let requestIDs = userSnapshot.get("receivedRequests") as! [String]
            
            print(requestIDs)
            
            for id in requestIDs {
                let userDoc = db.collection("users").document(id)
                let userSnapshot = try await userDoc.getDocument()
                let user = try userSnapshot.data(as: User.self)
                
                users.append(user)
            }

        } catch {
            print(error.localizedDescription)
        }
        self.receivedRequests = users
    }
    
    func acceptFriendRequest(senderID: String) async throws {
        do {
            guard let recipientID = self.currentUser?.id else {self.errorMessage = "acceptFriendRequest: couldnt get id of current user";self.alertShowing = true;return}
            
            let db = Firestore.firestore()
            
            let recipientDoc = db.collection("users").document(recipientID)
            let senderDoc = db.collection("users").document(senderID)
            
            // add each other as friends
            try await recipientDoc.updateData([
                "friends" : FieldValue.arrayUnion([senderID])
            ])
            try await senderDoc.updateData([
                "friends" : FieldValue.arrayUnion([senderID])
            ])
            
            //remove from outgoing/received requests
            try await recipientDoc.updateData([
                "receivedRequests" : FieldValue.arrayRemove([senderID])
            ])
            try await senderDoc.updateData([
                "outgoingRequests" : FieldValue.arrayRemove([recipientID])
            ])
        } catch {
            print(error.localizedDescription)
        }
        
        try await fetchReceivedRequests()
        try await fetchFriends()
    }
    
    func declineFriendRequest(senderID: String) async throws {
        do {
            guard let recipientID = self.currentUser?.id else {self.errorMessage = "couldnt get id of current user";self.alertShowing = true;return}
            
            let db = Firestore.firestore()
            
            let recipientDoc = db.collection("users").document(recipientID)
            let senderDoc = db.collection("users").document(senderID)
            
            //remove from outgoing/received requests
            try await recipientDoc.updateData([
                "receivedRequests" : FieldValue.arrayRemove([senderID])
            ])
            try await senderDoc.updateData([
                "outgoingRequests" : FieldValue.arrayRemove([recipientID])
            ])
        } catch {
            print(error.localizedDescription)
        }
        try await fetchReceivedRequests()
    }
    
    func cancelFriendRequest(recipientID: String) async throws {
        do {
            guard let senderID = self.currentUser?.id else {self.errorMessage = "couldnt get id of current user";self.alertShowing = true;return}
            let db = Firestore.firestore()
            
            let recipientDoc = db.collection("users").document(recipientID)
            let senderDoc = db.collection("users").document(senderID)
            
            try await recipientDoc.updateData([
                "receivedRequests" : FieldValue.arrayRemove([senderID])
            ])
            try await senderDoc.updateData([
                "outgoingRequests" : FieldValue.arrayRemove([recipientID])
            ])
        } catch {
            print(error.localizedDescription)
        }
        
        try await fetchOutgoingRequests()
    }
    
    
    
    
}
