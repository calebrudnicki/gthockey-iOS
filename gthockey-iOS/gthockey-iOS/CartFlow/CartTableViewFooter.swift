//
//  CartTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/16/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import Braintree
import BraintreeDropIn

class CartTableViewFooter: UIView {

    // MARK: Properties

    let paypalCheckoutButton = PillButton(title: "Checkout", backgroundColor: .paypalBlue, borderColor: .paypalBlue, isEnabled: true)

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        paypalCheckoutButton.addTarget(self, action: #selector(paypalCheckoutButtonTapped), for: .touchUpInside)

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
            paypalCheckoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            paypalCheckoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0)
        ])
    }

    // MARK: Action

    @objc private func paypalCheckoutButtonTapped() {
        print("Start checkout with paypal")
//        showDropIn(clientTokenOrTokenizationKey: <#T##String#>)
    }

//    func showDropIn(clientTokenOrTokenizationKey: String) {
//        let request =  BTDropInRequest()
//        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
//        { (controller, result, error) in
//            if (error != nil) {
//                print("ERROR")
//            } else if (result?.isCancelled == true) {
//                print("CANCELLED")
//            } else if let result = result {
//                // Use the BTDropInResult properties to update your UI
//                // result.paymentOptionType
//                // result.paymentMethod
//                // result.paymentIcon
//                // result.paymentDescription
//            }
//            controller.dismiss(animated: true, completion: nil)
//        }
//        self.present(dropIn!, animated: true, completion: nil)
//    }

}
