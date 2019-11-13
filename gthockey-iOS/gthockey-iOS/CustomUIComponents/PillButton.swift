//
//  PillButton.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/13/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class PillButton: UIButton {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        if traitCollection.userInterfaceStyle == .dark {
            layer.shadowColor = UIColor.white.cgColor
        } else {
            layer.shadowColor = UIColor.black.cgColor
        }

        setTitleColor(.white, for: .normal)

        titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        layer.cornerRadius = 30
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    convenience init(title: String, fillColor: UIColor) {
        self.init()

        setTitle(title, for: .normal)
        backgroundColor = fillColor
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
