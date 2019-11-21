//
//  SettingsTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/21/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    // MARK: Properties

    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    // MARK: Init

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviews([textField])

        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            textField.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])
    }

    // MARK: Setter

    public func set(with value: String) {
//        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.text = value
    }

}
