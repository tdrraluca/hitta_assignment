//
//  UIColor+Hex.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 07/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexRed: UInt16, hexGreen: UInt16, hexBlue: UInt16, alpha: CGFloat) {
        let red = CGFloat(hexRed) / 255.0
        let green = CGFloat(hexGreen) / 255.0
        let blue = CGFloat(hexBlue) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
