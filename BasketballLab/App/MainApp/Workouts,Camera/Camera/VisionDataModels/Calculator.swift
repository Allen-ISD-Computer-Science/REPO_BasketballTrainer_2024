//
//  VisionCalculations.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/27/24.
//

import Foundation
import UIKit



struct VisionCalculations {
    
    static func dribbleDetection(frameBuffer: FrameBuffer) -> Bool {
        let filteredFrames = frameBuffer.nonNilFrames()
        
        if filteredFrames.count >= 3 && frameBuffer[0].ball != nil {
            let deltaY1 = filteredFrames[0].ball!.y - filteredFrames[1].ball!.y
            let deltaY2 = filteredFrames[1].ball!.y - filteredFrames[2].ball!.y
            
            let doubleDeltaY = deltaY1 - deltaY2
            
            let ballHeight = filteredFrames[0].ball!.height
            
            let threshold = Int(UIScreen.main.bounds.width)*(ballHeight/2)
            
           // print("deltaY: " + String(deltaY1) + "  doubleDeltaY: " + String(doubleDeltaY))
            //print(doubleDeltaY)
            
            if(deltaY1 < 0 && deltaY2 >= 0) {
                return true
            }
            
            
            
        }
        return false
    }
}

struct TimeCalculations {
    
    static func formatElapsedTime(_ startDate: Date, _ endDate: Date) -> String {
      let elapsedTime = endDate.timeIntervalSince(startDate)
      let minutes = Int(elapsedTime / 60)
      let seconds = Int(elapsedTime.truncatingRemainder(dividingBy: 60))
      var timeText: String
      if minutes > 0 {
        timeText = "Elapsed time: \(minutes) minutes and \(seconds) seconds"
      } else {
        timeText = "Elapsed time: \(seconds) seconds"
      }
      return timeText
    }
    
    static func elapsedTime(startDate: Date, endDate: Date) -> Int {
        let elapsedTime = endDate.timeIntervalSince(startDate)
        return Int(elapsedTime)
    }
    
}
