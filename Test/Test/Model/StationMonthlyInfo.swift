//
//  Something.swift
//  Test
//
//  Created by Святослав Катола on 2/26/19.
//  Copyright © 2019 mezzoSoprano. All rights reserved.
//

import Foundation

struct StationMonthlyInfo {
    
    let monthNumber: UInt?
    let minTemp: Double?
    let maxTemp: Double?
    let airFrostDays: Int?
    let rainDays: Double?
    let sunHours: Double?
    
    var monthString: Month {
        
        get {
            switch monthNumber {
            case 1:
                return Month.January
            case 2:
                return Month.February
            case 3:
                return Month.March
            case 4:
                return Month.April
            case 5:
                return Month.May
            case 6:
                return Month.June
            case 7:
                return Month.July
            case 8:
                return Month.August
            case 9:
                return Month.September
            case 10:
                return Month.October
            case 11:
                return Month.November
            case 12:
                return Month.December
            default:
                return Month.Undefined
            }
        }
    }
    
    init(month: UInt?, degMin: Double?, degMax: Double?, airFrostDay: Int?, rain: Double?, sunHours: Double?) {
        
        self.monthNumber = month
        self.minTemp = degMin
        self.maxTemp = degMax
        self.airFrostDays = airFrostDay
        self.rainDays = rain
        self.sunHours = sunHours
    }
}

enum Month: String {
    
    case January, February, March, April, May, June, July, August, September, October, November, December, Undefined
    
}
