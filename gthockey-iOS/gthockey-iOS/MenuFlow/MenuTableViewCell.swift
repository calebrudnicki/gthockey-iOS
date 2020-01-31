//
//  MenuTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/23/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    // MARK: Properties

    private var isMissingIcon = false

    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
    }()

    private let optionLabel: UILabel = {
        let optionLabel = UILabel()
        optionLabel.font = UIFont(name:"HelveticaNeue-Light", size: 20.0)
        optionLabel.textColor = .white
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        return optionLabel
    }()

    // MARK: Init

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .techNavy
        contentView.addSubviews([iconImageView, optionLabel])
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        if isMissingIcon {
            NSLayoutConstraint.activate([
                optionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                optionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
                optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
            ])
        } else {
            NSLayoutConstraint.activate([
                iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
                iconImageView.heightAnchor.constraint(equalToConstant: 24.0),
                iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
            ])

            NSLayoutConstraint.activate([
                optionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                optionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12.0),
                optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
            ])
        }
    }

    // MARK: Setter

    public func set(with mainMenuOption: MainMenuOption) {
        if mainMenuOption.image == UIImage() {
            isMissingIcon = true
        }
        iconImageView.image = mainMenuOption.image
        optionLabel.text = mainMenuOption.description

        updateConstraints()
    }

    public func set(with adminMenuOption: AdminMenuOption) {
        if adminMenuOption.image == UIImage() {
            isMissingIcon = true
        }
        iconImageView.image = adminMenuOption.image
        optionLabel.text = adminMenuOption.description

        updateConstraints()
    }

}
