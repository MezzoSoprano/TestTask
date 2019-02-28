//
//  StringExtensions.swift
//  Test
//
//  Created by Святослав Катола on 2/27/19.
//  Copyright © 2019 mezzoSoprano. All rights reserved.
//

import Foundation

extension String {
    
    func condenseWhitespace() -> String {
        
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    func containsNumbers() -> Bool {
        
        // check if there's a range for a number
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits)
        
        // range will be nil if no numbers is found
        if let _ = range {
            return true
        } else {
            return false
        }
        
    }
}
