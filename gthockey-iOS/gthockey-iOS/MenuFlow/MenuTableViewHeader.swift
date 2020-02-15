//
//  MenuTableViewHeader.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/23/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MenuTableViewHeader: UIView {

    // MARK: Properties

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 32.0)
        titleLabel.text = "Welcome to GT Hockey App"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .techGold
        return titleLabel
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
