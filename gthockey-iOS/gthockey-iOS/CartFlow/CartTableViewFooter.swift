//
//  CartTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/16/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class CartTableViewFooter: UIView {

    // MARK: Properties

    let paypalCheckoutButton = PillButton(title: "Checkout", backgroundColor: .blue, borderColor: .blue, isEnabled: true)

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(paypalCheckoutButton)
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            paypalCheckoutButton.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            paypalCheckoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            paypalCheckoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12.0),
            paypalCheckoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 12.0)
        ])
    }

}