//
//  CartTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/16/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol CartTableViewFooterDelegate {
    func checkoutButtonTapped()
    func shippingButtonTapped()
}

class CartTableViewFooter: UIView {

    // MARK: Properties

    private let paypalCheckoutButton = PillButton(title: "Checkout", backgroundColor: .paypalBlue, borderColor: .paypalBlue, isEnabled: true)
    private let shippingButton = PillButton(title: "Shipping", backgroundColor: .gray, borderColor: .paypalBlue, isEnabled: true)
    public var delegate: CartTableViewFooterDelegate!

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        paypalCheckoutButton.addTarget(self, action: #selector(paypalCheckoutButtonTapped), for: .touchUpInside)
        shippingButton.addTarget(self, action: #selector(shippingButtonTapped), for: .touchUpInside)

        addSubview(paypalCheckoutButton)
        addSubview(shippingButton)
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
            paypalCheckoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
        ])

        NSLayoutConstraint.activate([
            shippingButton.topAnchor.constraint(equalTo: paypalCheckoutButton.bottomAnchor, constant: 12.0),
            shippingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            shippingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            shippingButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0)
        ])
    }

    // MARK: Action

    @objc private func paypalCheckoutButtonTapped() {
        delegate.checkoutButtonTapped()
    }

    @objc private func shippingButtonTapped() {
        delegate.shippingButtonTapped()
    }

}
