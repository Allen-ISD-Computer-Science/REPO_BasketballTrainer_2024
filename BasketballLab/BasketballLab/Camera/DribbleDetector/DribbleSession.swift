//
//  DribbleSession.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/28/24.
//

import Foundation
import SwiftUI


struct DribbleSessionView : View {
    
    var trainingSession : DribbleSession
    
    var body : some View {
        
        VStack(alignment: .leading) {
            Text("Training Results").font(.system(size: 40)).fontWeight(.semibold).frame(height: 100, alignment: .center).border(.green)
            Text("Free Dribbling").font(.title).border(.red)
            Text("test")
            
            Spacer()
            
            Button {
                
            } label : {
                ButtonView(text: "Return Home", imageName: "house", widthProportion: 0.75).background(Color.blue).foregroundColor(.white).cornerRadius(10)
            }
            
        }
        
        
        
    }
    
}

#Preview {
    DribbleSessionView(trainingSession: DribbleSession())
}


struct DribbleSession {
    
    let startDate = Date.now
    var endDate : Date?
    
    let totalDribbles = 0
    
    func elapsedTime() -> Int? {
        guard let endDate = self.endDate else {
            return nil
        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: startDate, to: endDate)
        return Int(components.minute!)
    }
    
    init() {
        print("initiated session")
    }
    
    
    
}
