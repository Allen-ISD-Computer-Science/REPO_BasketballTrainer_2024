//
//  RegistrationView.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var username = ""
    
    @State private var password = ""
    @State private var confirmedPassword = ""
    
    @State private var ageCheckBox = false
    @State private var TCCheckBox = false
    
    
    
    //@State private var birthDate : Date? = nil
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Spacer()
                
                Image(systemName: "gear")
                
                
                VStack(spacing: 24) {
                    
                    
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $email, title: "Email Address", placeholder: "Enter email").keyboardType(.emailAddress)
                        
                        if !email.isEmpty {
                            if email.contains("@") && email.contains(".") && (email.hasSuffix("com") || email.hasSuffix("net") || email.hasSuffix("gov") || email.hasSuffix("edu") || email.hasSuffix("org")) && !email.contains(" ") {
                            Image(systemName: "checkmark.circle.fill").padding(.top, 22).padding(.trailing, 8)
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill").padding(.top, 22).padding(.trailing, 8)
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                    }
                    
                    
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $username, title: "Username", placeholder: "Enter full name")
                        if !username.isEmpty && !username.contains(" ") {
                            Image(systemName: "checkmark.circle.fill").padding(.top, 22).padding(.trailing, 8)
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        }
                    }
                    
                    
                    
                    
                    ZStack(alignment: .trailing) {
                        SecureInputView(text: $password, title: "Create password", placeholder: "Create password (at least 6 characters)")
                        if !password.isEmpty {
                            if password.count >= 6 {
                                Image(systemName: "checkmark.circle.fill").padding(.top, 22).padding(.trailing, 8)
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill").padding(.top, 22).padding(.trailing, 8)
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                    
                    ZStack(alignment: .trailing) {
                        SecureInputView(text: $confirmedPassword, title: "Confirm password", placeholder: "Confirm password")
                        if !password.isEmpty && !confirmedPassword.isEmpty && confirmedPassword.count >= 6 {
                            if password == confirmedPassword {
                                Image(systemName: "checkmark.circle.fill").padding(.top, 22).padding(.trailing, 8)
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill").padding(.top, 22).padding(.trailing, 8)
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                                
                            }
                        }
                    }
                    
                    }.padding([.top, .bottom], 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Toggle(isOn: $ageCheckBox) {
                        Text("I am 13 years or older.").foregroundColor(Color.black).font(.headline)
                    }.padding([.leading, .trailing], 40)
                        .toggleStyle(iOSCheckboxToggleStyle())
                    
                    Toggle(isOn: $TCCheckBox) {
                        HStack(spacing: 3) {
                            Text("I have read the ").foregroundColor(Color.black)
                            Link("privacy policy", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!)
                             }
                            .font(.headline)
                    }.padding([.leading, .trailing], 40)
                        .toggleStyle(iOSCheckboxToggleStyle())
                }
                
                
                
                Button {
                    Task {
                        try await authViewModel.createUser(withEmail: email, password: password, username: username)
                    }
                } label: {
                    ButtonView(text: "Create Account", imageName: "arrow.right")
                        .background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                        .padding(.top, 10)
                }.disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.6)
                    .alert(authViewModel.errorMessage ?? "", isPresented: $authViewModel.alertShowing) { Button("OK", role: .cancel) { } }
                
                Spacer()
                                
                HStack {
                    Text("Already have an account?")
                    Button {
                        dismiss()
                    } label : {
                        Text("Log In")
                    }
                }
                
            }//vstack
            
            
        }.onTapGesture { hideKeyboard() } //navigation stack
    } //body
} //struct





extension RegistrationView : AuthenticationFormProtocol {
    var formIsValid : Bool {
        return !email.isEmpty 
        && email.contains("@")
        && !password.isEmpty
        && !username.isEmpty
        && confirmedPassword == password
        && !username.contains(" ")
        && TCCheckBox
        && ageCheckBox
    }
}


#Preview {
    RegistrationView().environmentObject(AuthViewModel())
}

