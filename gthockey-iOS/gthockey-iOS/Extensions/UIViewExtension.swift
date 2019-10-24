//
//  UIViewExtension.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/24/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }

}
