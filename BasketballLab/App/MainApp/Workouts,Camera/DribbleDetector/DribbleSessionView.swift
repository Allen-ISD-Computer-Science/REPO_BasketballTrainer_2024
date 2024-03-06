//
//  DribbleSession.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/28/24.
//

import Foundation
import SwiftUI


struct DribbleSessionView : View {
    
    @Binding var trainingSession : DribbleSession
    
    @Environment(\.dismiss) var dismiss
    
    var body : some View {
        
        VStack() {
            
            Text("Training Results").font(.system(size: 40)).fontWeight(.semibold).frame(height: 100, alignment: .center)
            
            Text("Free Dribbling").font(.title)
            
            Text(String("Total Dribbles: " + String(trainingSession.dribbles.count)))
            
            if trainingSession.endDate != nil {
                Text(TimeCalculations.formatElapsedTime(trainingSession.startDate, trainingSession.endDate!))
                
                
                FrequencyChartView(events: trainingSession.dribbles, startDate: trainingSession.startDate, endDate: trainingSession.endDate!).padding(40)
            }

            
            Spacer()
            
            Button {
                dismiss()
            } label : {
                ButtonView(text: "Return Home", imageName: "house").background(Color.blue).foregroundColor(.white).cornerRadius(10)
            }
            
        }.onAppear {
            
            print(UIDevice.current.orientation.isPortrait)
            AppDelegate.orientationLock = .allButUpsideDown
            
            if UIDevice.current.orientation.isPortrait {
                print("view is portrait, code ran")
                let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene
                windowScene?.requestGeometryUpdate(.iOS(
                    interfaceOrientations: .portrait
                ))
            }
        }
        
        
        
    }
    
}

#Preview {
//    DribbleSessionView(trainingSession: DribbleSession())
    Text("")
}


struct DribbleSession {
    
    let startDate = Date.now
    var endDate : Date?
    
    var dribbles = [Date]()
    
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
