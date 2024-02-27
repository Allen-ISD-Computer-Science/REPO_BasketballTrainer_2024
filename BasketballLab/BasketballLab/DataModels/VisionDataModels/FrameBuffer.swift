//
//  FrameBuffer.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/27/24.
//

import Foundation
import DequeModule

struct FrameBuffer {
    var locationBuffer : Deque<Frame>
    let maxLength : Int
    
    init(maxLength: Int) {
        self.maxLength = maxLength
        self.locationBuffer = []
    }
    
    func addLocationFrame(frame: Frame) {
        if (locationBuffer.count >= self.maxLength) {
            
        }
    }
    
}
