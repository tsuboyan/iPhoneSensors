//
//  UIView+Xib.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/09.
//

import UIKit

extension UIView {
    static var nibName: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static var reuseIdentifier: String {
        return nibName
    }
}
