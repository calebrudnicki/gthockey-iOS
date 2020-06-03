//
//  ShopDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/7/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ShopDetailViewController: GTHDetailViewController {

    // MARK: Properties
    
    private var apparelItem: Apparel?
    private var restrictedOptions: [ApparelRestrictedItem]?
    private var customOptions: [ApparelCustomItem]?
    
    //    private let restrictedOptionsStackView: UIStackView = {
    //        let restrictedOptionsStackView = UIStackView()
    //        restrictedOptionsStackView.axis = .vertical
    //        restrictedOptionsStackView.distribution = .equalCentering
    //        restrictedOptionsStackView.spacing = 8.0
    //        restrictedOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
    //        return restrictedOptionsStackView
    //    }()
    //
    //    private let customOptionsStackView: UIStackView = {
    //        let customOptionsStackView = UIStackView()
    //        customOptionsStackView.axis = .vertical
    //        customOptionsStackView.distribution = .equalCentering
    //        customOptionsStackView.spacing = 8.0
    //        customOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
    //        return customOptionsStackView
    //    }()
    //
    //    // MARK: Uncomment for shop
    ////    private let restrictedOptionsView = ShopRestrictedOptionsView()
    ////    private let customOptionsView = ShopCustomOptionsView()
    
    private let descriptionLabel = HTMLTextView(frame: .zero)
    
    private let unavailableLabel: HTMLTextView = {
        let unavailableLabel = HTMLTextView()
        unavailableLabel.textColor = .gray
        unavailableLabel.text = "We're sorry. Currently, shop is not available through our mobile application. If you would like to purchase GT Hockey merchandise, please visit our website at gthockey.com/shop."
        return unavailableLabel
    }()
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        secondaryLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        secondaryLabel.textColor = UIColor.shopDetailPriceColor
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
    
        primaryLabel.numberOfLines = 0
        primaryLabel.font = UIFont.DINCondensed.bold.font(size: 36.0)
        primaryLabel.textColor = UIColor.shopDetailTitleColor
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill",
                                     withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0)),
                             for: .normal)
        closeButton.tintColor = .label
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubviews([imageView, primaryLabel, secondaryLabel, descriptionLabel, unavailableLabel, closeButton])
        
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
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
            primaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            primaryLabel.trailingAnchor.constraint(lessThanOrEqualTo: secondaryLabel.leadingAnchor, constant: -12.0)
        ])
        
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 16.0),
            secondaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
            secondaryLabel.bottomAnchor.constraint(equalTo: primaryLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 12.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0)
        ])
        
        NSLayoutConstraint.activate([
            unavailableLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24.0),
            unavailableLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            unavailableLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
            unavailableLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -28.0)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0)
        ])
    }
    
    // MARK: Setter

    public func set(with apparel: Apparel, _ restrictedOptions: [ApparelRestrictedItem], _ customOptions: [ApparelCustomItem]) {
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

    @objc private func addToCartButtonTapped() {
//        addToCartButton.isLoading = true
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
        
        CartManager().add(cartDict: firestoreDict, completion: { result in
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
        
//        addToCartButton.isEnabled = shouldEnableAddToCartButton()
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
        
//        addToCartButton.isEnabled = shouldEnableAddToCartButton()
    }
    
}
