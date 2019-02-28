//
//  StationYearInfo.swift
//  Test
//
//  Created by Святослав Катола on 2/27/19.
//  Copyright © 2019 mezzoSoprano. All rights reserved.
//

import Foundation

struct StationYearInfo {
    
    let year: UInt?
    
    var minTemp: Double? {
        
        get {
            let min = monthInfo.min { a, b in
                if let first = a.minTemp, let second = b.minTemp {
                    return first < second
                }
                return false
            }
            return min?.minTemp
        }
    }
    
    var maxTemp: Double? {
        
        get {
            let max = monthInfo.max { a, b in
                if let first = a.maxTemp, let second = b.maxTemp {
                    return first < second
                }
                return false
            }
            return max?.maxTemp
        }
    }
    
    var rainMax: Double? {
        
        get {
            let max = monthInfo.max { a, b in
                if let first = a.rainDays, let second = b.rainDays {
                    return first < second
                }
                return false
            }
            return max?.rainDays
        }
    }
    
    var sunHoursMax: Double? {
        
        get {
            let max = monthInfo.max { a, b in
                if let first = a.sunHours, let second = b.sunHours {
                    return first < second
                }
                return false
            }
            return max?.sunHours
        }
    }
    
    var monthInfo = [StationMonthlyInfo]()
    
    init(year: UInt?, monthInfo: [StationMonthlyInfo]) {
        
        self.year = year
        self.monthInfo = monthInfo
    }
}
