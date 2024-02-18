//
//  StatBar.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import SwiftUI
import Foundation

struct StatBar: View {
    
    var name : String
    var value : Double?
    var color : Color
    
    var barWidth : CGFloat {
        CGFloat(3*Int(round((value ?? 0)*100)))
    }
    
    var percentage: String {
        if value != nil {
            return String(Int(round(value!*100))) + "%"
        } else {
            return "No Data Yet"
        }
    }
    

    
    var body: some View {
        
        VStack {
            
            Text(self.name).padding([.bottom], -4)
            
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
                    .fill(self.color.opacity(0.1))
                
                HStack {
                    RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
                        .fill(self.color.opacity(0.7))
                        .frame(width: barWidth, height: 15)
                    Spacer()
                }
                
            }
            .frame(width: 300, height: 15)
            
            Text(percentage)
                .padding([.top], 0)
                .font(.caption)
        }.padding(5)
        
        
    }
}

#Preview {
    StatBar(name: "Three Point Percentage",
            value: nil,
            color: Color(.red))
}
