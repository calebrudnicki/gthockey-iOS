//
//  UIStackViewExtension.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/22/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {

    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }

}
