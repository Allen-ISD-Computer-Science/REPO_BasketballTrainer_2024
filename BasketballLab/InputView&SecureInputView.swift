//
//  InputView.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text : String
    let title : String
    let placeholder : String

    
    var body: some View {
        
       VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
                .padding(.bottom, -5)
            
            Divider()
            
        
                TextField(placeholder, text: $text)
               .textInputAutocapitalization(.never)
               .disableAutocorrection(true)
                    .font(.system(size: 15)).frame(height: 30)
           
            
            Divider()
            
       }.padding([.leading, .trailing], 40)
            .frame(maxWidth: 650)
    }
}

struct SecureInputView: View {
    
    @Binding var text : String
    let title : String
    let placeholder : String

    
    var body: some View {
        
       VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
                .padding(.bottom, -5)
            
            Divider()
            
        
                SecureField(placeholder, text: $text).textInputAutocapitalization(.never)
               .disableAutocorrection(true)
                    .font(.system(size: 15)).frame(height: 30)
           
            
            Divider()
            
        }.padding([.leading, .trailing], 40)
            .frame(maxWidth: 650)
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
