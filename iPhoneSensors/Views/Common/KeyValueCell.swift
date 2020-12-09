//
//  KeyValueCell.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/09.
//

import UIKit

class KeyValueCell: UICollectionViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    static let cellHeight: CGFloat = 60
    
    func setup(key: String, value: String, unit: String? = nil) {
        keyLabel.text = key
        valueLabel.text = value
        unitLabel.text = unit
    }

}
