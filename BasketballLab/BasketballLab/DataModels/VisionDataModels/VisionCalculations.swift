//
//  VisionCalculations.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/27/24.
//

import Foundation



struct VisionCalculations {
    
    static func dribbleDetection(frameBuffer: FrameBuffer) {
        let filteredFrames = frameBuffer.nonNilFrames()
        
        if filteredFrames.count >= 3 && frameBuffer[0].ball != nil {
            let deltaY1 = filteredFrames[0].ball!.y1 - filteredFrames[1].ball!.y1
            let deltaY2 = filteredFrames[1].ball!.y1 - filteredFrames[2].ball!.y1
            
            let doubleDeltaY = deltaY1 - deltaY2
            
            if(deltaY1 < 0 && deltaY2 >= 0 && doubleDeltaY < 0) {
                print("dribble detected")
            }
            
        }
    }
}
