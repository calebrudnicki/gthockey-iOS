//
//  CardCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/30/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    // MARK: Init

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
            layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
            layer.shadowColor = UIColor.label.cgColor
        } else {
            layer.backgroundColor = UIColor.cellBackgroundLight.cgColor
            layer.shadowColor = UIColor.black.cgColor
        }

        layer.shadowOpacity = 0.2
        layer.shadowRadius = 7.0
        layer.cornerRadius = 6.0

        contentView.layer.cornerRadius = 6.0
        contentView.layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        contentView.layoutSubviews()
    }

}
