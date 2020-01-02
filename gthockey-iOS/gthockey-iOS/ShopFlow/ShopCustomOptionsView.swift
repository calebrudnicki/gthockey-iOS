//
//  ShopCustomOptionsView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/8/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol ShopCustomOptionsViewDelegate {
    func didEnter(option: String, for category: String)
}

// MARK: Under Construction (not used)

class ShopCustomOptionsView: UIView, UITextFieldDelegate {

//    public var delegate: ShopCustomOptionsViewDelegate!
//
//    // MARK: Properties
//
//    private let displayLabel: UILabel = {
//        let displayLabel = UILabel()
//        displayLabel.font = UIFont(name:"HelveticaNeue", size: 24.0)
//        displayLabel.text = "Number"
//        displayLabel.adjustsFontSizeToFitWidth = true
//        displayLabel.numberOfLines = 1
//        displayLabel.textAlignment = .left
//        displayLabel.translatesAutoresizingMaskIntoConstraints = false
//        return displayLabel
//    }()
//
//    private let optionsTextField = ShopOptionTextField()
//
//    // MARK: Init
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        optionsTextField.delegate = self
//
//        addSubviews([displayLabel, optionsTextField])
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
//            displayLabel.topAnchor.constraint(equalTo: topAnchor),
//            displayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            displayLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            optionsTextField.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 8.0),
//            optionsTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
//            optionsTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
//            optionsTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        delegate?.didEnter(option: textField.text ?? "", for: displayLabel.text ?? "")
//    }
//
//    // MARK: Setter
//
//    public func set(with customItem: ApparelCustomItem) {
//        displayLabel.text = customItem.getDisplayName()
//        optionsTextField.placeholder = customItem.getHelpText()
//
//        customizeTextField(for: customItem.getDisplayName())
//    }
//
//    // MARK: Private Functions
//
//    private func customizeTextField(for category: String) {
//        switch category {
//        case "Custom Number":
//            optionsTextField.keyboardType = .numberPad
//        case "Custom Name":
//            optionsTextField.autocapitalizationType = .allCharacters
//        default:
//            break
//        }
//    }

}
