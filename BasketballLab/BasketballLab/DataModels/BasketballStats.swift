//
//  BasketballStats.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import Foundation

struct BasketballStats : Codable {
    
    var lifetimeDribbles = 0
    var lifetimeFGA = 0
    var lifetimeFGM = 0
    var lifetime3PA = 0
    var lifetime3PM = 0
    
    var fieldGoalPercentage : Double? {
        if lifetimeFGA != 0 {
            return Double(lifetimeFGM/lifetimeFGA)
        } else {
            return nil
        }
    }
    
    var threePointPercentage : Double? {
        if lifetime3PA != 0 {
            return Double(lifetime3PM/lifetime3PA)
        } else {
            return nil
        }
    }
    
    mutating func updateStats(dribbles: Int, fga: Int, fgm: Int, threePointFGA: Int, threePointFGM: Int) {
        self.lifetimeDribbles += dribbles
        self.lifetimeFGA += fga
        self.lifetimeFGM += fgm
        self.lifetime3PA += threePointFGA
        self.lifetime3PM += threePointFGM
    }

    
}
