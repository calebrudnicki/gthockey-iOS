//
//  UIFontExtension.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

    public enum DINCondensed: String {

        case bold = "DINCondensed-Bold"

        public func font(size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
    
    public enum DINAlternate: String {

        case bold = "DINAlternate-Bold"

        public func font(size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }

}
