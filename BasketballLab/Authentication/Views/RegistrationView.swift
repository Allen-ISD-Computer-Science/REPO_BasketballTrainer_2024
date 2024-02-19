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
                    
                    InputView(text: $email, title: "Email Address", placeholder: "Enter email", autoCaps: false)
                    InputView(text: $fullName, title: "Full Name", placeholder: "Enter full name", autoCaps: true)
                    InputView(text: $password, title: "Create password", placeholder: "Create password", autoCaps: false, isSecureField: true)
                    InputView(text: $confirmedPassword, title: "Confirm password", placeholder: "Confirm password", autoCaps: false, isSecureField: true)
                    }.padding([.top, .bottom], 20)
                
                
                
                Button {
                    Task {
                        try await authViewModel.createUser(withEmail: email, password: password, fullName: fullName)
                    }
                } label: {
                    ButtonView(text: "Create Account", imageName: "arrow.right", widthProportion: (3/4))
                        .background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                        .padding(.top, 0)
                }
                
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

#Preview {
    RegistrationView().environmentObject(AuthViewModel())
}
