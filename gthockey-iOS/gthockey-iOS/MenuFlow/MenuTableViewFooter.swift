//
//  MenuTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/23/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MenuTableViewFooter: UIView {

    private let versionLabel: UILabel = {
        let versionLabel = UILabel()
        versionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        versionLabel.text = "Made in ATL | Version 1.0"
        versionLabel.adjustsFontSizeToFitWidth = true
        versionLabel.numberOfLines = 1
        versionLabel.textAlignment = .center
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.textColor = .gray
        return versionLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(versionLabel)
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            versionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            versionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            versionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
