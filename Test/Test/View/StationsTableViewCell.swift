//
//  StaionsTableViewCell.swift
//  Test
//
//  Created by Святослав Катола on 2/27/19.
//  Copyright © 2019 mezzoSoprano. All rights reserved.
//

import UIKit

protocol StationsCellDelegate {
    
    func didTapGetInfo(for name: String, index: Int)
}

class StationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var staionNameLabel: UILabel!
    @IBOutlet weak var stationSubtitleLabel: UILabel!
    
    var delegate: StationsCellDelegate?
    
    @IBAction func getInfoTapped(_ sender: Any) {
        
        delegate?.didTapGetInfo(for: staionNameLabel.text!, index: staionNameLabel.tag)
    }
}
