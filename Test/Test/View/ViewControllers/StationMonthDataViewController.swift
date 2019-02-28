//
//  StationMonthDataViewController.swift
//  Test
//
//  Created by Святослав Катола on 2/27/19.
//  Copyright © 2019 mezzoSoprano. All rights reserved.
//

import UIKit

class StationMonthDataViewController: UIViewController {
    
    let monthCellIdentifier = "monthCell"
    
    var recievedMonthData = [StationMonthlyInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension StationMonthDataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.recievedMonthData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.monthCellIdentifier, for: indexPath)
        cell.textLabel?.text = recievedMonthData[indexPath.row].monthString.rawValue
        cell.detailTextLabel?.text = "🌡: \(String(recievedMonthData[indexPath.row].maxTemp ?? 0))° / \(String(recievedMonthData[indexPath.row].minTemp ?? 0))°  ☔️: \(String(recievedMonthData[indexPath.row].rainDays ?? 0)) mm  ☀️: \(String(recievedMonthData[indexPath.row].sunHours ?? 0)) hours  ❄️: \(String(recievedMonthData[indexPath.row].airFrostDays ?? 0)) days"
        return cell
    }
}

