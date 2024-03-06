//
//  LoginView.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
              //  Spacer()
                
                Image(systemName: "gear").padding(.bottom, 30)
                
                
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email Address", placeholder: "Enter email").keyboardType(.emailAddress)
                    SecureInputView(text: $password, title: "Password", placeholder: "Enter password")
                    }.padding([.top, .bottom], 20)
                
                
                
               Button { //Sign in button
                    Task {
                        try await authViewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    ButtonView(text: "Log In", imageName: "arrow.right")
                        .background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                        .padding([.top, .bottom], 30)
                }
                .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.6)
                    .alert(authViewModel.errorMessage ?? "", isPresented: $authViewModel.alertShowing) { Button("OK", role: .cancel) { } }
                
                
            
                
                HStack {
                    Text("Don't have an account?")
                    
                    NavigationLink {
                        RegistrationView().navigationBarBackButtonHidden(true)
                    } label : {
                        Text("Sign up")
                    }

                    
                }
            }
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

extension LoginView : AuthenticationFormProtocol {
    var formIsValid : Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty
    }
}

#Preview {
    LoginView().environmentObject(AuthViewModel())
}
