//
//  UIColorExtension.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/22/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }

    static let techNavy = UIColor(red: 37/255, green: 47/255, blue: 86/255, alpha: 1.0)
    static let techGold = UIColor(red: 213/255, green: 193/255, blue: 104/255, alpha: 1.0)
    static let techCream = UIColor(red: 225/255, green: 212/255, blue: 159/255, alpha: 1.0)

    static let winGreen = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 1.0)
    static let lossRed = UIColor(red: 178/255, green: 34/255, blue: 34/255, alpha: 1.0)

    static let spaceCadet = UIColor(hex: 0x252F56)

}
