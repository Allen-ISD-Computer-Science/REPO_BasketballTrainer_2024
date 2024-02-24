//
//  AuthViewModel.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/18/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid : Bool { get }
}

@MainActor
class AuthViewModel : ObservableObject {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    
    @Published var errorMessage : String? = nil
    @Published var alertShowing = false
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            self.errorMessage = nil
        } catch {
            print("failed login w/ error \(error.localizedDescription)")
            self.errorMessage = "Incorrect password or email address or account doesn't exist"
            self.alertShowing = true
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        print("create user function ran")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
            self.errorMessage = nil
        } catch {
            print("Failed create user in createUser function in AuthViewModel. Error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
            self.alertShowing = true
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() //signs out user on backend
            self.userSession = nil //wipes out userSession and brings us to login screen
            self.currentUser = nil //make currentUser nil
            self.errorMessage = nil
        } catch {
            print("Failed to sign out with error \(error.localizedDescription)")
            self.errorMessage = "Failed to sign out"
            self.alertShowing = true
        }
    }
    
    func deleteAccount() async throws {
        do {
            
            guard let user = Auth.auth().currentUser else {return}
            try await user.delete()
            signOut()
            
        } catch {
            print("Unable to delete user")
            print("Error: \(error.localizedDescription)")
        }
        
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
    }
    
    
}
