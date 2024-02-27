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
    var autoCaps : Bool
    var isSecureField = false

    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
                .padding(.bottom, -5)
            
            Divider()
            
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            
            Divider()
            
        }.if(!autoCaps) { view in
            view.textInputAutocapitalization(.never)
        }.padding([.leading, .trailing], 40)
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com", autoCaps: true)
}
