//
//  ShopCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/31/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//
import UIKit
import SDWebImage

class ShopCollectionViewCell: GTHCardCollectionViewCell {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        primaryLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        primaryLabel.textColor = UIColor.shopCellTitleColor
        primaryLabel.lineBreakMode = .byTruncatingTail
        primaryLabel.numberOfLines = 2
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
                
        secondaryLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        secondaryLabel.textColor = UIColor.shopCellPriceColor
        secondaryLabel.numberOfLines = 1
        secondaryLabel.sizeToFit()
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView(frame: contentView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        imageView.addSubview(view)
        imageView.bringSubviewToFront(view)

        contentView.addSubviews([imageView, primaryLabel, secondaryLabel])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            primaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            primaryLabel.trailingAnchor.constraint(equalTo: secondaryLabel.leadingAnchor, constant: -4.0),
            primaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])

        NSLayoutConstraint.activate([
            secondaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            secondaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])
    }

    // MARK: Setter

    public func set(with apparel: Apparel) {
        imageView.sd_setImage(with: apparel.getImageURL(), placeholderImage: nil)
        primaryLabel.text = apparel.getName()
        secondaryLabel.text = apparel.getPriceString()
    }

}
