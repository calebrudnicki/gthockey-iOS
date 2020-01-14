//
//  AllUsersTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/13/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class AllUsersTableViewFooter: UIView {

    // MARK: Properties

    private let totalUsersLabel: UILabel = {
        let totalUsersLabel =  UILabel()
        totalUsersLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        totalUsersLabel.textColor = .gray
        totalUsersLabel.adjustsFontSizeToFitWidth = true
        totalUsersLabel.numberOfLines = 1
        totalUsersLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalUsersLabel
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(totalUsersLabel)
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            totalUsersLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            totalUsersLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 12.0),
            totalUsersLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12.0),
            totalUsersLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0),
            totalUsersLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // MARK: Setter

    public func set(with count: Int) {
        totalUsersLabel.text = "Total app users: \(String(describing: count))"
    }

}
