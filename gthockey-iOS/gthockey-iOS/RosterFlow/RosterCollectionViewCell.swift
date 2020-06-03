//
//  RosterCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/4/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class RosterCollectionViewCell: GTHCardPlusCollectionViewCell {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        imageView.layer.cornerRadius = 14.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        shadowView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0.0, y: 16.0, blur: 16.0, spread: 0.0)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
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

        shadowView.addSubview(imageView)
        contentView.addSubviews([shadowView, primaryLabel, secondaryLabel])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: 120.0),
            shadowView.widthAnchor.constraint(equalToConstant: 120.0)
        ])
        
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 16.0),
            primaryLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            primaryLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 8.0),
            secondaryLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -8.0)
        ])
    }

    // MARK: Setter

    public func set(with player: Player) {
        imageView.sd_setImage(with: player.headshotURL, placeholderImage: nil)
        primaryLabel.text = player.lastName
        secondaryLabel.text = player.position == .Manager ? "" : "#\(player.number)"
    }

}
