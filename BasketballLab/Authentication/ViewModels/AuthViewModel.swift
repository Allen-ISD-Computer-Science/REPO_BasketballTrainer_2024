//
//  AuthViewModel.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/18/24.
//

import Foundation
import Observation
import Firebase


class AuthViewModel : ObservableObject {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    
    init() {
        
    }
    
    
    func signIn(withEmail email: String, password: String) async throws {
        print("sign in")
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        print("register")
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
    
    
}
