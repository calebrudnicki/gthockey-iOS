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

// MARK: Under Construction

class ShopDetailViewController: UIViewController {

    // MARK: Properties

    private var apparelItem: Apparel?
    private var restrictedOptions: [ApparelRestrictedItem]?
    private var customOptions: [ApparelCustomItem]?

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
        priceLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()

    private let separatorView1: UIView = {
        let separatorView1 = UIView()
        separatorView1.backgroundColor = .techGold
        separatorView1.translatesAutoresizingMaskIntoConstraints = false
        return separatorView1
    }()

    private let descriptionLabel = HTMLTextView()

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

    // MARK: Uncomment for shop
//    private let restrictedOptionsView = ShopRestrictedOptionsView()
//    private let customOptionsView = ShopCustomOptionsView()

    private let unavailableLabel: HTMLTextView = {
        let unavailableLabel = HTMLTextView()
        unavailableLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        unavailableLabel.textColor = .gray
        unavailableLabel.text = "We're sorry. Currently, shop is not available through our mobile application. If you would like to purchase GT Hockey merchandise, please visit our website at gthockey.com/shop."
        return unavailableLabel
    }()

    private let addToCartButton = PillButton(title: "Add to cart", backgroundColor: .winGreen, borderColor: .winGreen, isEnabled: false)
    private let closeButton = FloatingCloseButton()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)

        backgroundView.addSubviews([imageView, headlineLabel, priceLabel, separatorView1, descriptionLabel, separatorView2,
                                    /*restrictedOptionsStackView, customOptionsStackView,*/unavailableLabel, addToCartButton, closeButton])

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
            descriptionLabel.topAnchor.constraint(equalTo: separatorView1.bottomAnchor, constant: 9.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 9.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -9.0)
        ])

        NSLayoutConstraint.activate([
            separatorView2.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12.0),
            separatorView2.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            separatorView2.widthAnchor.constraint(equalTo: separatorView1.widthAnchor),
            separatorView2.heightAnchor.constraint(equalToConstant: 1.0)
        ])

        NSLayoutConstraint.activate([
            unavailableLabel.topAnchor.constraint(equalTo: separatorView2.bottomAnchor, constant: 9.0),
            unavailableLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 9.0),
            unavailableLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -9.0)
        ])

        // MARK: Uncomment for shop
//        NSLayoutConstraint.activate([
//            restrictedOptionsStackView.topAnchor.constraint(equalTo: separatorView2.bottomAnchor, constant: 12.0),
//            restrictedOptionsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
//            restrictedOptionsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
//        ])
//
//        NSLayoutConstraint.activate([
//            customOptionsStackView.topAnchor.constraint(equalTo: restrictedOptionsStackView.bottomAnchor, constant: 12.0),
//            customOptionsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
//            customOptionsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
//        ])

        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: unavailableLabel.bottomAnchor, constant: 24.0),
            addToCartButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            addToCartButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            addToCartButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -28.0),
            addToCartButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
            closeButton.widthAnchor.constraint(equalToConstant: 32.0),
            closeButton.heightAnchor.constraint(equalToConstant: 32.0)
        ])
    }

    // MARK: Setter

    public func set(with apparel: Apparel, _ restrictedOptions: [ApparelRestrictedItem], _ customOptions: [ApparelCustomItem]) {
        imageView.sd_setImage(with: apparel.getImageURL(), placeholderImage: nil)
        headlineLabel.text = apparel.getName()
        priceLabel.text = apparel.getPriceString()
        descriptionLabel.setText(with: apparel.getDescription())

        // MARK: Uncomment for shop
//        self.restrictedOptions = restrictedOptions
//        for restrictedOption in restrictedOptions {
//            let shopRestrictedOptionsView = ShopRestrictedOptionsView()
//            shopRestrictedOptionsView.set(with: restrictedOption)
//            shopRestrictedOptionsView.delegate = self
//            restrictedOptionsStackView.addArrangedSubview(shopRestrictedOptionsView)
//        }
//
//        self.customOptions = customOptions
//        for customOption in customOptions {
//            let shopCustomOptionsView = ShopCustomOptionsView()
//            shopCustomOptionsView.set(with: customOption)
//            shopCustomOptionsView.delegate = self
//            restrictedOptionsStackView.addArrangedSubview(shopCustomOptionsView)
//        }

        apparelItem = apparel
    }

    // MARK: Action

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func addToCartButtonTapped() {
        addToCartButton.isLoading = true
        var price = apparelItem?.getPrice()
        var firestoreDict: [String: Any] = ["id": (apparelItem?.getID())!,
                                             "name": (apparelItem?.getName())!,
                                             "imageURL": (apparelItem?.getImageURL())?.description]
        var attributesDict: [String: Any] = [:]

        guard let restrictedOptions = restrictedOptions else { return }
        for restrictedOption in restrictedOptions {
//            guard let value = restrictedOption.getValue(), value == "" else { return }
            let key = restrictedOption.getDisplayName()
            attributesDict[key.lowercased()] = restrictedOption.getValue()
        }

        guard let customOptions = customOptions else { return }
        for customOption in customOptions {
            let key = customOption.getDisplayName()
            if customOption.getValue() != nil && customOption.getValue() != "" {
                price = (price ?? 0.0) + customOption.getExtraCost()
                attributesDict[key.lowercased()] = customOption.getValue()
            }
        }

        firestoreDict["price"] = price
        firestoreDict["attributes"] = attributesDict

        let cartHelper = CartHelper()
        cartHelper.add(cartDict: firestoreDict, completion: { result in
            if result {
                self.dismiss(animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Add to Cart Failed",
                                              message: nil,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }

    // MARK: Helper Functions

    private func shouldEnableAddToCartButton() -> Bool {
        guard let restrictedOptions = restrictedOptions else { return false }
        for restrictedOption in restrictedOptions {
            if restrictedOption.getValue() == nil || restrictedOption.getValue() == "" {
                return false
            }
        }

        guard let customOptions = customOptions else { return false }
        for customOption in customOptions {
            if customOption.getIsRequired() && (customOption.getValue() == nil || customOption.getValue() == "") {
                return false
            }
        }

        return true
    }

}

extension ShopDetailViewController: ShopRestrictedOptionsViewDelegate {

    func didSelect(option: String, for category: String) {
        guard let restrictedOptions = restrictedOptions else { return }

        for restrictedOption in restrictedOptions {
            if restrictedOption.getDisplayName() == category {
                restrictedOption.setValue(with: option)
            }
        }

        addToCartButton.isEnabled = shouldEnableAddToCartButton()
    }

}

extension ShopDetailViewController: ShopCustomOptionsViewDelegate {

    func didEnter(option: String, for category: String) {
        guard let customOptions = customOptions else { return }

        for customOption in customOptions {
            if customOption.getDisplayName() == category {
                customOption.setValue(with: option)
            }
        }

        addToCartButton.isEnabled = shouldEnableAddToCartButton()
    }

}
