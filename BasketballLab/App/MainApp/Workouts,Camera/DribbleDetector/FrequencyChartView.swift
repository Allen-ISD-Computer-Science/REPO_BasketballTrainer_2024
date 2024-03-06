//
//  FrequencyChartView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 2/29/24.
//

import Foundation
import SwiftUI
import Charts

struct FrequencyChartView : View {
    let events : [Date]
    let startDate : Date
    let endDate : Date
    
    var body: some View {
        Chart(processEvents(startDate: startDate, endDate: endDate, events: events, unitTimeInSeconds: 10)) { data in
            LineMark(
                x: .value("Time (s)", data.time),
                y: .value("Dribbles/10s", data.numberOfEvents)
            )
            //.interpolation(.linear) // Optional: Set interpolation for smoother line
        }
        .chartXAxisLabel(position: .bottom, alignment: .center) {
            Text("Time (s)")
        }
        .chartYAxisLabel(position: .leading, alignment: .center) {
            Text("Dribbles/10s")
        }.onAppear {
            enablePortraitMode()
        }
    }
}

struct FrequencyPerUnitTime : Identifiable {
    let id = UUID()
    let time : Int
    let numberOfEvents : Int
}

func processEvents(startDate: Date, endDate: Date, events: [Date], unitTimeInSeconds: Int) -> [FrequencyPerUnitTime] {
    let eventsInSeconds = convertFromDatesToSeconds(startDate: startDate, events: events)
    var dataPoints: [FrequencyPerUnitTime] = [FrequencyPerUnitTime(time: 0, numberOfEvents: 0)]
    let elapsedTime = Double(TimeCalculations.elapsedTime(startDate: startDate, endDate: endDate))
    
    
    for x in 0...Int(floor(Double(elapsedTime)/Double(unitTimeInSeconds))) {
        
        let lowerBound = (x*unitTimeInSeconds)
        let upperBound = ((x+1)*unitTimeInSeconds)
        let midPoint = (lowerBound + upperBound)/2
        
        
        //let range = (x*unitTimeInSeconds)..<((x+1)*unitTimeInSeconds)
        //print(String(range.first!) + " to " + String(range.last!))
                                             
        let filteredArray = eventsInSeconds.filter { $0 >= lowerBound && $0 < upperBound  }
        let numberOfEvents = filteredArray.count
        
        let frequency = FrequencyPerUnitTime(time: midPoint, numberOfEvents: numberOfEvents)
        dataPoints.append(frequency)
    }
    //for item in dataPoints {
        //print("Time: " + String(item.time) + "    DPUT: " + String(item.numberOfEvents))
    //}
    return dataPoints
}

func convertFromDatesToSeconds(startDate: Date, events: [Date]) -> [Int] {
    if (events.count >= 1) {
        var seconds = [Int]()
        for event in events {
            let timeDifference = Int(event.timeIntervalSince(startDate))
            seconds.append(timeDifference)
        }
        return seconds
    }
    return []
}
