//
//  SettingsTextFieldTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/14/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol SettingsTextFieldTableViewCellDelegate {
    func updatedValue(to newValue: String, for category: String)
}

class SettingsTextFieldTableViewCell: UITableViewCell {

    // MARK: Properties

    public var delegate: SettingsTextFieldTableViewCellDelegate!

    private let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont(name:"Helvetica Neue", size: 20.0)
        categoryLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.numberOfLines = 1
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryLabel
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    // MARK: Init

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .gthBackgroundColor

        textField.delegate = self
        contentView.addSubviews([categoryLabel, textField])

        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
        ])

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12.0),
            textField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0)
        ])
    }

    // MARK: Setter

    public func set(with category: String, value: String? = "", isEditable: Bool) {
        categoryLabel.text = category
        textField.text = value
        textField.isUserInteractionEnabled = isEditable
    }
    
}

extension SettingsTextFieldTableViewCell: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard
            let category = categoryLabel.text,
            let text = textField.text,
            text.count > 0
            else { return }

        delegate.updatedValue(to: text, for: category)
    }

}
