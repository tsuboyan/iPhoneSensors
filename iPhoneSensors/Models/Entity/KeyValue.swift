//
//  KeyValue.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/10.
//

import UIKit

struct KeyValue {
    let key: String
    let value: String
    let unit: String?
    
    init(key: String, value: String, unit: String? = nil) {
        self.key = key
        self.value = value
        self.unit = unit
    }
}
