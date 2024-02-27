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
    
    @State private var firstName = ""
    @State private var lastName = ""
    
    @State private var fullName = "" //use this for now....
    
    @State private var password = ""
    @State private var confirmedPassword = ""
    
    
    
    //@State private var birthDate : Date? = nil
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                
                Image("ashwin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .padding(.top, 30)
                    .padding(.bottom, 40)
                
                
                VStack(spacing: 24) {
                    
                    
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $email, title: "Email Address", placeholder: "Enter email", autoCaps: false)
                        
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
                        InputView(text: $fullName, title: "Full Name", placeholder: "Enter full name", autoCaps: true)
                        if !fullName.isEmpty {
                            Image(systemName: "checkmark.circle.fill").padding(.top, 22).padding(.trailing, 8)
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        }
                    }
                    
                    
                    
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $password, title: "Create password", placeholder: "Create password", autoCaps: false, isSecureField: true)
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
                        InputView(text: $confirmedPassword, title: "Confirm password", placeholder: "Confirm password", autoCaps: false, isSecureField: true)
                        if !password.isEmpty && !confirmedPassword.isEmpty {
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
                
                
                
                Button {
                    Task {
                        try await authViewModel.createUser(withEmail: email, password: password, fullName: fullName)
                    }
                } label: {
                    ButtonView(text: "Create Account", imageName: "arrow.right", widthProportion: (3/4))
                        .background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                        .padding(.top, 0)
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
            }
        }
    }
}


extension RegistrationView : AuthenticationFormProtocol {
    var formIsValid : Bool {
        return !email.isEmpty 
        && email.contains("@")
        && !password.isEmpty
        && !fullName.isEmpty
        && confirmedPassword == password
    }
}


#Preview {
    RegistrationView().environmentObject(AuthViewModel())
}
