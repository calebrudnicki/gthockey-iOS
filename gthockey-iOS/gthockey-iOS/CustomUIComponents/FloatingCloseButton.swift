//
//  FloatingCloseButton.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/19/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class FloatingCloseButton: UIButton {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        var closeButtonImage: UIImage?

        if #available(iOS 13.0, *) {
            closeButtonImage = UIImage(systemName: "xmark.circle.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 40.0, weight: .bold))
        } else {
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
        }

        setImage(closeButtonImage, for: .normal)

        translatesAutoresizingMaskIntoConstraints = false

        layer.shadowOpacity = 0.2
        layer.shadowRadius = 7.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
