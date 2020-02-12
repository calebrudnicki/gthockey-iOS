//
//  FloatingCloseButton.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/19/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class FloatingCloseButton: UIButton {

    // MARK: Properties

    private var closeButtonImage: UIImage?

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        if #available(iOS 13.0, *) {
            closeButtonImage = UIImage(systemName: "xmark.circle.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 40.0, weight: .bold))
            layer.shadowColor = UIColor.secondaryLabel.cgColor
        } else {
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
            layer.shadowColor = UIColor.black.cgColor
        }

        setupButton()
    }

    init(frame: CGRect, withPresetColor color: UIColor) {
        super.init(frame: frame)

        if #available(iOS 13.0, *) {
            closeButtonImage = UIImage(systemName: "xmark.circle.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(color)
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 40.0, weight: .bold))
            layer.shadowColor = UIColor.secondaryLabel.cgColor
        } else {
            if color == .white {
                closeButtonImage = UIImage(named: "CloseButtonWhite")?.withRenderingMode(.alwaysOriginal)
                layer.shadowColor = color.cgColor
            } else {
                closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
                layer.shadowColor = UIColor.black.cgColor
            }
        }

        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        setImage(closeButtonImage, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 4.0
    }

}
