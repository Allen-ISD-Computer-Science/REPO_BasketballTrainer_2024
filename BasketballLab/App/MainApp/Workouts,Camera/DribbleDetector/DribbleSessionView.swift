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
            
            
           /* if #available(iOS 16.0, *) {
                guard
                    let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene,
                    let rootViewController = windowScene.windows.first?.rootViewController
                else { return }
                rootViewController.debugSupportedOrientations()
                
                rootViewController.setNeedsUpdateOfSupportedInterfaceOrientations()
                windowScene.requestGeometryUpdate(.iOS(
                    interfaceOrientations: .portrait
                ))
            }  */
            
            let errorHandler: (Error) -> Void = { error in
                print("An error occurred: \(error)")
            }
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait), errorHandler: errorHandler)
            
        }.onDisappear {
            print("onDisappear session view ran")
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



extension UIViewController {
  func debugSupportedOrientations() {
    let mask = supportedInterfaceOrientations
    var supported = [String]()
    if mask.contains(.portrait) {
      supported.append("Portrait")
    }
    if mask.contains(.landscapeLeft) {
      supported.append("Landscape Left")
    }
    if mask.contains(.landscapeRight) {
      supported.append("Landscape Right")
    }
    if mask.contains(.portraitUpsideDown) {
      supported.append("Portrait Upside Down")
    }
    let orientationString = supported.joined(separator: ", ")
    print("Supported Orientations: \(orientationString)")
  }
}
