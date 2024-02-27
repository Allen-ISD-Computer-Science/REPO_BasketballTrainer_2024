//
//  User.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import Foundation


struct User : Identifiable, Codable {
    
    let id : String
    let fullName : String
    let email : String
    
    var initials : String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        } else {
            return ""
        }
    }
    
}

extension User {
    static var mockUser = User(id: NSUUID().uuidString, fullName: "Onik Hoque", email: "test@gmail.com")
}
