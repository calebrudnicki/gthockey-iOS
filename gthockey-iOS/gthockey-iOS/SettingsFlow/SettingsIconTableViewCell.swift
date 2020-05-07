//
//  SettingsIconTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/22/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol SettingsIconTableViewCellDelegate {
    func didSelectCell(with appIcon: AppIcon)
}

class SettingsIconTableViewCell: UITableViewCell {

    // MARK: Properties

    public var delegate: SettingsIconTableViewCellDelegate!
    private var appIcon: AppIcon?

    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.sizeToFit()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
    }()

    private let iconTitle: UILabel = {
        let iconTitle = UILabel()
        iconTitle.font = UIFont(name: "Helvetica Neue", size: 20.0)
        iconTitle.numberOfLines = 1
        iconTitle.translatesAutoresizingMaskIntoConstraints = false
        return iconTitle
    }()

    // MARK: Init

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .gthBackgroundColor

        tintColor = .techNavy
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(cellTapped)))

        contentView.addSubviews([iconImageView, iconTitle])
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            iconTitle.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            iconTitle.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12.0),
            iconTitle.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    // MARK: Action

    @objc private func cellTapped() {
        delegate?.didSelectCell(with: appIcon ?? .Buzz)
    }

    // MARK: Setter

    public func set(to appIcon: AppIcon, iconName: String, isSelected: Bool) {
        self.appIcon = appIcon
        iconImageView.image = UIImage(named: appIcon.description)
        iconTitle.text = iconName
        accessoryType = isSelected ? .checkmark : .none
    }

}
