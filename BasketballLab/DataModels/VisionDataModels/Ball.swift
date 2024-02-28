//
//  File.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/26/24.
//

import Foundation
import DequeModule
import CoreML
import Vision




struct Ball {
    
    let x1 : Int
    let y1 : Int
    
    let x2 : Int
    let y2 : Int
    
    
    init(x1: Int, y1: Int, x2: Int, y2: Int) {
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2
    }
}


