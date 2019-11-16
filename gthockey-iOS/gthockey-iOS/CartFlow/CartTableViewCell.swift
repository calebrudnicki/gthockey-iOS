//
//  CartTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/15/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class CartTableViewCell: UITableViewCell {

    // MARK: Properties

    private let productImageView: UIImageView = {
        let productImageView = UIImageView()
        productImageView.backgroundColor = .gray
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleAspectFill
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        return productImageView
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name:"Helvetica Neue", size: 20.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 1
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    private let attributesStack: UIStackView = {
        let attributesStack = UIStackView()
        attributesStack.axis = .vertical
        attributesStack.distribution = .fillEqually
        attributesStack.spacing = 8.0
        attributesStack.translatesAutoresizingMaskIntoConstraints = false
        return attributesStack
    }()

    // MARK: Init

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviews([productImageView, nameLabel, attributesStack])

        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0)
        ])

        NSLayoutConstraint.activate([
            attributesStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0),
            attributesStack.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8.0),
            attributesStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            attributesStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8.0)
        ])
    }

    // MARK: Setter

    public func set(with cartItem: CartItem) {
        productImageView.sd_setImage(with: cartItem.getImageURL(), placeholderImage: nil)
        nameLabel.text = cartItem.getName()

        for attribute in cartItem.getAttributes() {
            let attributeLabel = UILabel()
            attributeLabel.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
            attributeLabel.adjustsFontSizeToFitWidth = true
            attributeLabel.numberOfLines = 1
            attributeLabel.translatesAutoresizingMaskIntoConstraints = false
            attributeLabel.text = "\(attribute.key) - \(attribute.value as! String)"
            attributesStack.addArrangedSubview(attributeLabel)
        }

        updateConstraints()
    }


}
