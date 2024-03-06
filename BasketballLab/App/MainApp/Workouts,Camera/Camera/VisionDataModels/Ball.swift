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
    
    let x : Int
    let y : Int
    
    let height : Int
    
    
    init(x: Int, y: Int, height: Int) {
        self.x = x
        self.y = y
        self.height = height
    }
}


