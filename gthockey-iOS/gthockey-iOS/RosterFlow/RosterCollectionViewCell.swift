//
//  RosterCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/4/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class RosterCollectionViewCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let firstNameLabel: UILabel = {
        let firstNameLabel = UILabel()
        firstNameLabel.font = UIFont(name:"Helvetica-Neue Light", size: 16.0)
        firstNameLabel.numberOfLines = 1
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return firstNameLabel
    }()

    private let lastNameLabel: UILabel = {
        let lastNameLabel = UILabel()
        lastNameLabel.font = UIFont(name:"Helvetica Neue", size: 24.0)
        lastNameLabel.numberOfLines = 1
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return lastNameLabel
    }()

    private let numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.font = UIFont(name:"Helvetica Neue", size: 24.0)
        numberLabel.numberOfLines = 1
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
            layer.shadowColor = UIColor.label.cgColor
        } else {
            layer.backgroundColor = UIColor.white.cgColor
            layer.shadowColor = UIColor.black.cgColor
        }

        layer.shadowOpacity = 0.2
        layer.shadowRadius = 7.0
        layer.cornerRadius = 6.0

        contentView.layer.cornerRadius = 6.0
        contentView.layer.masksToBounds = true

        contentView.addSubview(imageView)
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(numberLabel)

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
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4.0),
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
            firstNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -4.0)
        ])

        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor),
            lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
            lastNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0)
        ])

        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: lastNameLabel.trailingAnchor, constant: 4.0),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0)
        ])
    }

    public func set(with player: Player) {
        imageView.sd_setImage(with: player.getImageURL(), placeholderImage: nil)
        firstNameLabel.text = player.getFirstName()
        lastNameLabel.text = player.getLastName()
        numberLabel.text = "#\(player.getNumber())"
    }

}
