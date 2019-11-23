//
//  ShopCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/31/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//
import UIKit
import SDWebImage

class ShopCollectionViewCell: CardCollectionViewCell {

    // MARK: Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 24.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.sizeToFit()
        return titleLabel
    }()

    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.numberOfLines = 1
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubviews([imageView, titleLabel, priceLabel])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0)
        ])

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])

        super.updateConstraints()
    }

    // MARK: Setter
    
    public func set(with apparel: Apparel) {
        imageView.sd_setImage(with: apparel.getImageURL(), placeholderImage: nil)
        titleLabel.text = apparel.getName()
        priceLabel.text = "$\(apparel.getPrice().description)"
    }

}
