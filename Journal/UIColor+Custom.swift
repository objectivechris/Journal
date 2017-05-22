//
//  UIColor+Custom.swift
//  Journal
//
//  Created by Rene, Christopher (CAI - Atlanta) on 5/22/17.
//  Copyright © 2017 Christopher Rene. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }
}
