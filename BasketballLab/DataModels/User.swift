//
//  User.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import Foundation


struct User : Identifiable, Codable {
    
    let id : String
    let username : String
    let email : String
    
    var receivedRequests = [String]() //ids of accounts that request me
    var outgoingRequests = [String]() //ids of accounts that I requested
    var friends = [String]()
    
    
    
    var initials : String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: username) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        } else {
            return ""
        }
    }
    
}

struct FriendRequest : Codable {
    let senderID : String
    let recipientID : String
}


extension User {
    static var mockUser = User(id: NSUUID().uuidString, username: "Onik Hoque", email: "test@gmail.com")
}
