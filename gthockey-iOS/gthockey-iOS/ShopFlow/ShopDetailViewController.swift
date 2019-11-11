//
//  ShopDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/7/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseFirestore

class ShopDetailViewController: UIViewController {

    // MARK: Properties

    private var apparelItem: [String : Any]?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()

    private let closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let headlineLabel: UILabel = {
        let headlineLabel = UILabel()
        headlineLabel.numberOfLines = 0
        headlineLabel.sizeToFit()
        headlineLabel.font = UIFont(name: "HelveticaNeue-Light", size: 36.0)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        return headlineLabel
    }()

    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.numberOfLines = 0
        priceLabel.sizeToFit()
        priceLabel.font = UIFont(name: "HelveticaNeue", size: 24.0)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()

    private let separatorView1: UIView = {
        let separatorView1 = UIView()
        separatorView1.backgroundColor = .techGold
        separatorView1.translatesAutoresizingMaskIntoConstraints = false
        return separatorView1
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()

    private let separatorView2: UIView = {
        let separatorView2 = UIView()
        separatorView2.backgroundColor = .techGold
        separatorView2.translatesAutoresizingMaskIntoConstraints = false
        return separatorView2
    }()

    private let restrictedOptionsStackView: UIStackView = {
        let restrictedOptionsStackView = UIStackView()
        restrictedOptionsStackView.axis = .vertical
        restrictedOptionsStackView.distribution = .equalCentering
        restrictedOptionsStackView.spacing = 8.0
        restrictedOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
        return restrictedOptionsStackView
    }()

    private let customOptionsStackView: UIStackView = {
        let customOptionsStackView = UIStackView()
        customOptionsStackView.axis = .vertical
        customOptionsStackView.distribution = .equalCentering
        customOptionsStackView.spacing = 8.0
        customOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
        return customOptionsStackView
    }()

    private let restrictedOptionsView = ShopRestrictedOptionsView()
    private let restrictedOptionsView1 = ShopRestrictedOptionsView()

    private let customOptionsView = ShopCustomOptionsView()

    private let addToCartButton: UIButton = {
        let addToCartButton = UIButton()
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        addToCartButton.backgroundColor = .winGreen
        addToCartButton.layer.cornerRadius = 30
        addToCartButton.clipsToBounds = true
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        return addToCartButton
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        var closeButtonImage: UIImage?

        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            closeButtonImage = UIImage(named: "CloseButtonWhite")?.withRenderingMode(.alwaysOriginal)
        } else {
            view.backgroundColor = .white
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
        }

        closeButton.setImage(closeButtonImage, for: .normal)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)

//        restrictedOptionsStackView.addArrangedSubview(restrictedOptionsView)
//        restrictedOptionsStackView.addArrangedSubview(restrictedOptionsView1)

        backgroundView.addSubviews([imageView, closeButton, headlineLabel, priceLabel, separatorView1, descriptionLabel,
                                    separatorView2, restrictedOptionsStackView, customOptionsStackView, addToCartButton])

        updateViewConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12.0),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            closeButton.widthAnchor.constraint(equalToConstant: 32.0),
            closeButton.heightAnchor.constraint(equalToConstant: 32.0)
        ])

        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0),
            headlineLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            headlineLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24.0)
        ])

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 8.0),
            priceLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            separatorView1.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12.0),
            separatorView1.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            separatorView1.widthAnchor.constraint(equalTo: priceLabel.widthAnchor),
            separatorView1.heightAnchor.constraint(equalToConstant: 1.0)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: separatorView1.bottomAnchor, constant: 12.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            separatorView2.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12.0),
            separatorView2.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            separatorView2.widthAnchor.constraint(equalTo: separatorView1.widthAnchor),
            separatorView2.heightAnchor.constraint(equalToConstant: 1.0)
        ])

        NSLayoutConstraint.activate([
            restrictedOptionsStackView.topAnchor.constraint(equalTo: separatorView2.bottomAnchor, constant: 12.0),
            restrictedOptionsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            restrictedOptionsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            customOptionsStackView.topAnchor.constraint(equalTo: restrictedOptionsStackView.bottomAnchor, constant: 12.0),
            customOptionsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            customOptionsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: customOptionsStackView.bottomAnchor, constant: 24.0),
            addToCartButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            addToCartButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            addToCartButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -28.0),
            addToCartButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Setter

    public func set(with apparel: Apparel, _ restrictedOptions: [ApparelRestrictedItem], _ customOptions: [ApparelCustomItem]) {
        imageView.sd_setImage(with: apparel.getImageURL(), placeholderImage: nil)
        headlineLabel.text = apparel.getName()
        priceLabel.text = "$\(apparel.getPrice().description)"
        descriptionLabel.text = apparel.getDescription()

        for restrictedOption in restrictedOptions {
            let shopRestrictedOptionsView = ShopRestrictedOptionsView()
            shopRestrictedOptionsView.set(with: restrictedOption)
            restrictedOptionsStackView.addArrangedSubview(shopRestrictedOptionsView)
        }

        for customOption in customOptions {
            let shopCustomOptionsView = ShopCustomOptionsView()
            shopCustomOptionsView.set(with: customOption)
            restrictedOptionsStackView.addArrangedSubview(shopCustomOptionsView)
        }

        apparelItem = apparel.convertToArray()
    }

    // MARK: Action

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func addToCartButtonTapped() {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData(["cart": apparelItem], merge: true)
        }
    }

}
