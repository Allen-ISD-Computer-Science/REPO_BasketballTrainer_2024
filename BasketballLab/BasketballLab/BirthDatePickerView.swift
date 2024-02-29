//
//  BirthDatePickerView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/19/24.
//

import Foundation
import SwiftUI

struct BirthDatePickerView: View {
    
    @Binding var birthDate : Date 
    


    var body: some View {
        
        
        
        VStack(alignment: .leading) {
            
            Text("Date of Birth")
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
                .padding(.bottom, -5)

            Divider()
            DatePicker("random", selection: $birthDate, in: ...Date.now, displayedComponents: .date)
                .labelsHidden().scaleEffect(0.8).padding([.leading], -10).padding([.top, .bottom], -4)
            Divider()
        }.padding([.leading, .trailing], 40)
        
        
    }
}

#Preview {
   // BirthDatePickerView()
    Text("placeholder")
}
