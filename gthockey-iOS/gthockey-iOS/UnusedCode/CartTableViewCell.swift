//
//  CartTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/15/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//
//
//import UIKit
//import SDWebImage

// MARK: Under Construction (not used)

//class CartTableViewCell: UITableViewCell {

//    // MARK: Properties
//
//    private let productImageView: UIImageView = {
//        let productImageView = UIImageView()
//        productImageView.backgroundColor = .gray
//        productImageView.clipsToBounds = true
//        productImageView.contentMode = .scaleAspectFill
//        productImageView.translatesAutoresizingMaskIntoConstraints = false
//        return productImageView
//    }()
//
//    private let nameLabel: UILabel = {
//        let nameLabel = UILabel()
//        nameLabel.font = UIFont(name:"Helvetica Neue", size: 20.0)
//        nameLabel.adjustsFontSizeToFitWidth = true
//        nameLabel.numberOfLines = 1
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        return nameLabel
//    }()
//
//    private let attributesStack: UIStackView = {
//        let attributesStack = UIStackView()
//        attributesStack.axis = .vertical
//        attributesStack.distribution = .fillEqually
//        attributesStack.translatesAutoresizingMaskIntoConstraints = false
//        return attributesStack
//    }()
//
//    private let priceLabel: UILabel = {
//        let priceLabel = UILabel()
//        priceLabel.font = UIFont(name:"Helvetica Neue", size: 16.0)
//        priceLabel.adjustsFontSizeToFitWidth = true
//        priceLabel.numberOfLines = 1
//        priceLabel.translatesAutoresizingMaskIntoConstraints = false
//        return priceLabel
//    }()
//
//    // MARK: Init
//
//    override init(style: CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        isUserInteractionEnabled = false
//        contentView.addSubviews([productImageView, nameLabel, attributesStack, priceLabel])
//
//        updateConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func updateConstraints() {
//        super.updateConstraints()
//
//        NSLayoutConstraint.activate([
//            productImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8.0),
//            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
//            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8.0),
//            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            productImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
//            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            nameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
//            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8.0),
//            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0)
//        ])
//
//        NSLayoutConstraint.activate([
//            attributesStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0),
//            attributesStack.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8.0),
//            attributesStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0)
//        ])
//
//        NSLayoutConstraint.activate([
//            priceLabel.topAnchor.constraint(greaterThanOrEqualTo: attributesStack.bottomAnchor, constant: 8.0),
//            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8.0),
//            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: productImageView.bottomAnchor)
//        ])
//    }
//
//    // MARK: Setter
//
//    public func set(with cartItem: CartItem) {
//        productImageView.sd_setImage(with: cartItem.getImageURL(), placeholderImage: nil)
//        nameLabel.text = cartItem.getName()
//
//        for attribute in cartItem.getAttributes() {
//            let attributeLabel = UILabel()
//            attributeLabel.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
//            attributeLabel.adjustsFontSizeToFitWidth = true
//            attributeLabel.numberOfLines = 1
//            attributeLabel.translatesAutoresizingMaskIntoConstraints = false
//            attributeLabel.text = "\(attribute.key) - \(attribute.value as! String)"
//            attributesStack.addArrangedSubview(attributeLabel)
//        }
//
//        priceLabel.text = cartItem.getPriceString()
//
//        updateConstraints()
//    }

//}
