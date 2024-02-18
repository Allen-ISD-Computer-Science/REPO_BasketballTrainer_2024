//
//  ProfileView.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import SwiftUI

struct ProfileView: View {
    

    
    var body: some View {
        
        ScrollView {
            
            
            
            HStack {
                Text("Hi , Onik").padding()
                    .font(.largeTitle)
                    .bold()
                    .frame(alignment: .trailing)
                    .border(.green)
                    .padding([.top, .leading], 40)
                Spacer()
            }
            
            Divider()
            
            StatBar(name: "Field Goal Percentage",
                    value: 0.547,
                    color: Color(.red))
            
            StatBar(name: "Three Point Percentage",
                    value: 0.387,
                    color: Color(.green))
            
            StatBar(name: "Free Throw",
                    value: 0.826,
                    color: Color(.blue))
            
            Divider()
            
            
            
            
            
            
            
            
            
        }
    }
    
    
    
}

#Preview {
    ProfileView()
}
