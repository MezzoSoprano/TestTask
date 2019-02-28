//
//  APIManager.swift
//  Test
//
//  Created by Святослав Катола on 2/26/19.
//  Copyright © 2019 mezzoSoprano. All rights reserved.
//

import UIKit
import CoreLocation

class MeteoDataTypeURL {
    
    static var baseURL: String = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/"
    
    static func getModifiedRequest(with stationName: String) -> URLRequest {
        
        let urlString = baseURL + "\(stationName.lowercased())data.txt"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        return request
    }
}

final class APIStaionsManager: APIManager {
    
    let sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    } ()
    
    init(sessionConfiguration: URLSessionConfiguration) {
        self.sessionConfiguration = sessionConfiguration
    }
    
    func fetchStationsWith(stationName: String, completionHandler: @escaping (APIResult<MeteoStaion>) -> Void) {
        
        fetch(request: MeteoDataTypeURL.getModifiedRequest(with: stationName), parse: { (data) -> MeteoStaion? in
            
            //parsing received data into objects
            if let fullData = String(data: data, encoding: String.Encoding.utf8) {
                
                var monthlyModels = [StationMonthlyInfo]()
                var yearModels = [StationYearInfo]()
                
                let monthlyInfoLines = fullData.components(separatedBy: "\n") as [String]
                let name = monthlyInfoLines[0]
                
                for index in 7...monthlyInfoLines.count - 1 {
                    
                    //extracting values from string
                    let monthlyData = monthlyInfoLines[index].condenseWhitespace().replacingOccurrences(of: "*", with: "").replacingOccurrences(of: "#", with: "").components(separatedBy: " ")
                    
                    //getting monthy values from line
                    let modelYear = UInt(monthlyData[0])
                    let modelMonth = UInt(monthlyData[1])
                    let modelDegMax = Double(monthlyData[2])
                    let modelDegMin = Double(monthlyData[3])
                    let modelAirFrost = Int(monthlyData[4])
                    let modelRain = Double(monthlyData[5])
                    let modelSunHours = Double(monthlyData[6])
                    
                    //creating year models using monthly models
                    let previousYear = UInt(monthlyInfoLines[index - 1].condenseWhitespace().components(separatedBy: " ")[0])
                    
                    if previousYear != nil && previousYear != modelYear {
                        yearModels.append(StationYearInfo(year: previousYear, monthInfo: monthlyModels))
                        
                        //removing monthly data if year model created
                        monthlyModels.removeAll()
                    }
                    
                    //adding extracted info to monthy models
                    monthlyModels.append(StationMonthlyInfo(month: modelMonth, degMin: modelDegMin, degMax: modelDegMax, airFrostDay: modelAirFrost, rain: modelRain, sunHours: modelSunHours))
                    
                }
                
                let meteoModel = MeteoStaion(name: name, yearInfo: yearModels)
                return meteoModel
                
            } else {
                print("Parsing Error")
                return nil
            }
        }, completionHandler: completionHandler)
    }
}
