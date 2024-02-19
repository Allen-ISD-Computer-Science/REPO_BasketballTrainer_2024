//
//  AuthViewModel.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/18/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


@MainActor
class AuthViewModel : ObservableObject {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    
    func signIn(withEmail email: String, password: String) async throws {
        print("sign in")
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        print("create user function ran")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user) 
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("Failed create user in createUser function in AuthViewModel. Error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
    }
    
    
}
