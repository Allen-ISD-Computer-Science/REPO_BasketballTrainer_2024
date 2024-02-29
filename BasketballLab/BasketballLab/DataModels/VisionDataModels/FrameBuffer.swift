//
//  FrameBuffer.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/27/24.
//

import Foundation
import DequeModule

struct FrameBuffer {
    
    var buffer : Deque<Frame>
    let maxLength : Int
    
    init(maxLength: Int) {
        self.maxLength = maxLength
        self.buffer = []
    }
    
    mutating func addLocationFrame(frame: Frame) {
        if (buffer.count >= self.maxLength) {
            self.buffer.removeLast()
        }
        self.buffer.prepend(frame)
    }
    
    subscript(index: Int) -> Frame {
            if index >= 0 && index < buffer.count {
                return self.buffer[index]
            } else {
                fatalError("index given was out of range of FrameBuffer")
            }
        }
    
    func nonNilFrames() -> Deque<Frame> {
        let filteredArray = self.buffer.filter { $0.ball != nil }
        return filteredArray
    }
    
}
