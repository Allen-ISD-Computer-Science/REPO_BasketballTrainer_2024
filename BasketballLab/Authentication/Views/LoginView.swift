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
                
                
                
                Image("ashwin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .padding(.top, 80)
                    .padding(.bottom, 40)
                
                
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email Address", placeholder: "Enter email", autoCaps: false)
                    InputView(text: $password, title: "Password", placeholder: "Enter password", autoCaps: false, isSecureField: true)
                    }.padding([.top, .bottom], 20)
                
                
                
                Button {
                    Task {
                        try await authViewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    ButtonView(text: "Log In", imageName: "arrow.right", widthProportion: (3/4))
                        .background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                        .padding(.top, 60)
                }
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                    
                    NavigationLink {
                        RegistrationView().navigationBarBackButtonHidden(true)
                    } label : {
                        Text("Sign up")
                    }

                    
                }
                
            }
        }
    }
    
}

#Preview {
    LoginView().environmentObject(AuthViewModel())
}
