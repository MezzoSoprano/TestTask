//
//  MeteoStation.swift
//  Test
//
//  Created by Святослав Катола on 2/27/19.
//  Copyright © 2019 mezzoSoprano. All rights reserved.
//

import Foundation

class MeteoStaion {
    
    let name: String
    
    var yearInfo = [StationYearInfo]()
    
    var tempMin: Double? {
        get {
            let min = yearInfo.min { a, b in
                if let first = a.minTemp, let second = b.minTemp {
                    return first < second
                }
                return false
            }
            return min?.minTemp
        }
    }
    
    var tempMax: Double? {
        
        get {
            let max = yearInfo.max { a, b in
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
            let max = yearInfo.max { a, b in
                if let first = a.rainMax, let second = b.rainMax {
                    return first > second
                }
                return false
            }
            return max?.rainMax
        }
    }
    
    init(name: String, yearInfo: [StationYearInfo]) {
        
        self.name = name
        self.yearInfo = yearInfo
    }
}
