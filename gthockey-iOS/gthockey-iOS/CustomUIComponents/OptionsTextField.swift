//
//  OptionsTextField.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/30/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class OptionsTextField: UITextField {

    // MARK: Properties

    private let padding = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.00, right: 8.0)

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        if #available(iOS 13.0, *) {
            textColor = .label
            layer.borderColor = UIColor.secondaryLabel.cgColor
        } else {
            textColor = .black
            layer.borderColor = UIColor.black.cgColor
        }

        layer.borderWidth = 1.0
        font = UIFont(name:"HelveticaNeue-Light", size: 20.0)

        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}

