//
//  ViewController.swift
//  Test
//
//  Created by Святослав Катола on 2/26/19.
//  Copyright © 2019 mezzoSoprano. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    let stationCellIdentifier = "staionsCell"
    let segueToYearInfoIdentifier = "staionInfoSegue"
    
    let stationNames = ["Bradford", "Camborne", "Chivenor", "Durham", "Eastbourne", "Heathrow", "Hurn", "Lerwick", "Leuchars", "Manston", "Sheffield", "Waddington", "Yeovilton", "Ballypatrick", "Cardiff", "Rossonwye"]
    
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    lazy var stationManager = APIStaionsManager(sessionConfiguration: URLSessionConfiguration.default)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupSearchController()
        
        // Reload the table
        self.tableView.reloadData()
        
    }
    
    fileprivate func setupSearchController() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.isHidden = true
            
            return controller
        })()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is StationYearDataViewController {
            
            let vc = segue.destination as? StationYearDataViewController
            if let data = sender as? [StationYearInfo] {
                
                vc?.yearStaionData = data
                
            } else {
                
                print("Couldn't pass the data")
            }
        }
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        
        if resultSearchController.searchBar.isHidden {
            
            self.searchButton.image = UIImage(named: "cancelIcon8")
            self.tableView.setContentOffset(.zero, animated: true)
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.tableView.tableHeaderView = resultSearchController.searchBar
            self.resultSearchController.searchBar.isHidden = false
            
        } else {
            
            self.searchButton.image = UIImage(named: "searchIcon8")
            self.tableView.contentInset = UIEdgeInsets(top: -50, left: 0, bottom: 0, right: 0)
            self.resultSearchController.searchBar.isHidden = true
        }
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (stationNames as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  self.resultSearchController.isActive {
            return self.filteredTableData.count
        } else {
            return self.stationNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.stationCellIdentifier, for: indexPath) as! StationsTableViewCell
        
        cell.delegate = self
        cell.stationSubtitleLabel.text = "Histrorical max/min temperature: "
        
        if self.resultSearchController.isActive {
            
            cell.staionNameLabel.text = filteredTableData[indexPath.row]
            cell.staionNameLabel.tag = indexPath.row
            return cell
        } else {
            
            cell.staionNameLabel.text = stationNames[indexPath.row]
            cell.staionNameLabel.tag = indexPath.row
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stationName: String?
        
        if (resultSearchController.isActive) {
            
            stationName = filteredTableData[indexPath.row]
        }
        else {
            
            stationName = stationNames[indexPath.row]
        }
        
        stationManager.fetchStationsWith(stationName: stationName!) { (result) in
            
            switch result {
                
            case .Success(let recievedStaion):
                
                let dataToPass = recievedStaion.yearInfo
                self.performSegue(withIdentifier: self.segueToYearInfoIdentifier, sender: dataToPass)
                
            case .Failure(let error as NSError):
                
                self.createAlert(title: "Unable to get data", message: error.localizedDescription)
                print(error)
                
            default: break
            }
        }
        
        //removing search controller
        self.resultSearchController.dismiss(animated: true, completion: nil)
    }
    
}

extension MainViewController: StationsCellDelegate {
    
    func didTapGetInfo(for name: String, index: Int) {
        
        //getting selected cell
        if let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? StationsTableViewCell {
            
            //checking if info already shown
            if !(cell.stationSubtitleLabel.text?.containsNumbers())! {
                
                stationManager.fetchStationsWith(stationName: name) { (result) in
                    
                    switch result {
                        
                    case .Success(let recievedStaion):
                        
                        cell.stationSubtitleLabel.text?.append(" \(String(recievedStaion.tempMax ?? 0))° / \(String(recievedStaion.tempMin ?? 0))°")
                        
                    case .Failure(let error as NSError):
                        
                        print(error)
                        
                    default: break
                    }
                }
            }
        }
    }
}

