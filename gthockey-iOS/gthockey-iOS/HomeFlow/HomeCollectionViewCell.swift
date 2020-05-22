//
//  HomeCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/30/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCollectionViewCell: CardCollectionViewCell {

    // MARK: Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.DINCondensed.bold.font(size: 16.0)
        dateLabel.textColor = UIColor(red: 241/255, green: 242/255, blue: 235/255, alpha: 0.6)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.numberOfLines = 1
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        let view = UIView(frame: contentView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        imageView.addSubview(view)
        imageView.bringSubviewToFront(view)

        contentView.addSubviews([imageView, dateLabel, titleLabel])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            dateLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -4.0)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])

        super.updateConstraints()
    }

    // MARK: Setter

    public func set(with news: News) {
        imageView.sd_setImage(with: news.getImageURL(), placeholderImage: nil)
        dateLabel.text = news.getDate().formatted
        titleLabel.text = news.getTitle()
    }

}
