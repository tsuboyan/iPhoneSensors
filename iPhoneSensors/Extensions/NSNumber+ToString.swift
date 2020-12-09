//
//  NSNumber+ToString.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/10.
//

import Foundation

extension NSNumber {
    var toString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        // formatter.groupingSeparator = ","
        // formatter.groupingSize = 3
        if let result = formatter.string(from: self) {
            return result
        } else {
            return ""
        }
    }
    
}
