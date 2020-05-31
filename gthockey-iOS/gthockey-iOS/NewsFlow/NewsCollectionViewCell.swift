//
//  NewsCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCollectionViewCell: GTHCardCollectionViewCell {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        secondaryLabel.font = UIFont.DINCondensed.bold.font(size: 16.0)
        secondaryLabel.textColor = UIColor.newsCellDateColor
        secondaryLabel.adjustsFontSizeToFitWidth = true
        secondaryLabel.numberOfLines = 1
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        primaryLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        primaryLabel.textColor = UIColor.newsCellTitleColor
        primaryLabel.lineBreakMode = .byTruncatingTail
        primaryLabel.numberOfLines = 2
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView(frame: contentView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        imageView.addSubview(view)
        imageView.bringSubviewToFront(view)
        
        layer.applySketchShadow(color: .black, alpha: 0.5, x: 0.0, y: 16.0, blur: 16.0, spread: 0.0)
        
        contentView.addSubviews([imageView, secondaryLabel, primaryLabel])
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
            secondaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            secondaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            secondaryLabel.bottomAnchor.constraint(equalTo: primaryLabel.topAnchor, constant: -4.0)
        ])

        NSLayoutConstraint.activate([
            primaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            primaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            primaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])
    }

    // MARK: Setter

    public func set(with news: News) {
        imageView.sd_setImage(with: news.imageURL, placeholderImage: nil)
        secondaryLabel.text = news.date.standardFormatted
        primaryLabel.text = news.title
    }

}
