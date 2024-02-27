//
//  Drills.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/24/24.
//

import Foundation


struct Drill : Hashable {
    let name : String
    
    init(name: String) {
        self.name = name
    }
    
}


struct Drills {
    
    static let drill = Drill(name: "Free Throws")
    
    static let drills = [
        Drill(name: "Three Point Shot"),
        Drill(name: "Spin Move"),
        Drill(name: "Crossover"),
        Drill(name: "Layups")
    ]
}
