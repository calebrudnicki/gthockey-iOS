//
//  RosterCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/4/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class RosterCollectionViewCell: GTHCardCollectionViewCell {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0.0, y: 16.0, blur: 16.0, spread: 0.0)
        
        imageView.layer.shadowColor = UIColor.purple.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 1.0
        imageView.clipsToBounds = false
        
        imageView.layer.cornerRadius = 14.0
        imageView.layer.masksToBounds = true
        
        primaryLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        primaryLabel.allowsDefaultTighteningForTruncation = true
        primaryLabel.numberOfLines = 1
        primaryLabel.sizeToFit()
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        secondaryLabel.font = UIFont.DINCondensed.bold.font(size: 16.0)
        secondaryLabel.textColor = .black
        secondaryLabel.numberOfLines = 1
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layer.masksToBounds = false

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
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
            primaryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            primaryLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8.0),
            secondaryLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8.0)
        ])
    }

    // MARK: Setter

    public func set(with player: Player) {
        imageView.sd_setImage(with: player.headshotURL, placeholderImage: nil)
        primaryLabel.text = player.lastName
        secondaryLabel.text = "#\(player.number)"
    }

}
