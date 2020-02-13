//
//  AllUsersTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/13/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class AllUsersTableViewCell: UITableViewCell {

    // MARK: Properties

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name:"Helvetica Neue", size: 20.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 1
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    private let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.font = UIFont(name:"HelveticaNeue-light", size: 16.0)
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.numberOfLines = 1
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()

    private let lastLoginLabel: UILabel = {
        let lastLoginLabel = UILabel()
        lastLoginLabel.font = UIFont(name:"HelveticaNeue-light", size: 16.0)
        lastLoginLabel.adjustsFontSizeToFitWidth = true
        lastLoginLabel.numberOfLines = 1
        lastLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        return lastLoginLabel
    }()

    private let fcmTokenLabel: UILabel = {
        let fcmTokenLabel = UILabel()
        fcmTokenLabel.font = UIFont(name:"HelveticaNeue-light", size: 16.0)
        fcmTokenLabel.lineBreakMode = .byTruncatingTail
        fcmTokenLabel.numberOfLines = 1
        fcmTokenLabel.translatesAutoresizingMaskIntoConstraints = false
        return fcmTokenLabel
    }()

    // MARK: Init

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviews([nameLabel, emailLabel, lastLoginLabel, fcmTokenLabel])
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
        ])

        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
        ])

        NSLayoutConstraint.activate([
            lastLoginLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8.0),
            lastLoginLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            lastLoginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
        ])

        NSLayoutConstraint.activate([
            fcmTokenLabel.topAnchor.constraint(equalTo: lastLoginLabel.bottomAnchor, constant: 8.0),
            fcmTokenLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            fcmTokenLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
        ])
    }

    // MARK: Setter

    public func set(with appUser: AppUser) {
        nameLabel.text = appUser.getFirstName() + " " + appUser.getLastName()
        emailLabel.text = appUser.getEmail()
        lastLoginLabel.text = appUser.getLastLogin()
        fcmTokenLabel.text = appUser.getFCMToken()
    }

}
