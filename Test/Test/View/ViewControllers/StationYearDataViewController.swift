//
//  StationYearDataViewController.swift
//  Test
//
//  Created by Святослав Катола on 2/27/19.
//  Copyright © 2019 mezzoSoprano. All rights reserved.
//

import UIKit

class StationYearDataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let yearCellIdentifier = "yearCell"
    let segueToMonthIdentifier = "stationMonthInfoSegue"
    
    var yearStaionData =  [StationYearInfo]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is StationMonthDataViewController
        {
            let vc = segue.destination as? StationMonthDataViewController
            if let data = sender as? [StationMonthlyInfo] {
                vc?.recievedMonthData = data
                
            } else {
                
                print("Couldn't pass the data")
            }
        }
    }
}

extension StationYearDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.yearStaionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.yearCellIdentifier, for: indexPath)
        cell.textLabel?.text = String(yearStaionData[indexPath.row].year!)
        cell.textLabel?.tag = indexPath.row
        cell.detailTextLabel?.text = "🌡: \(String(yearStaionData[indexPath.row].maxTemp ?? 0))° / \(String(yearStaionData[indexPath.row].minTemp ?? 0))°  ☔️: \(String(yearStaionData[indexPath.row].rainMax ?? 0)) mm  ☀️: \(String(yearStaionData[indexPath.row].sunHoursMax ?? 0)) hours"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: self.segueToMonthIdentifier, sender: yearStaionData[indexPath.row].monthInfo)
    }
}
