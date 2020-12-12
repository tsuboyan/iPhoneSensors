//
//  CGFloat+ToString.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/10.
//

import UIKit

extension CGFloat {
    var toString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        if let result = formatter.string(from: NSNumber(value: Float(self))) {
            return result
        } else {
            return ""
        }
    }
}
