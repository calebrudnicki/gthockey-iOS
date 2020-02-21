//
//  CartTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/16/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import Stripe
import Alamofire

protocol CartTableViewFooterDelegate {
    func paymentOptionsButtonTapped()
    func shippingOptionsButtonTapped()
    func payButtonTapped()
}

class CartTableViewFooter: UIView {

    // MARK: Properties

    public var delegate: CartTableViewFooterDelegate!

    private var paymentTextField: STPPaymentCardTextField = {
        let paymentTextField = STPPaymentCardTextField()
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        return paymentTextField
    }()

    private let buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 12.0
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsStackView
    }()

    private let paymentOptionsButton = PillButton(title: "Payment Options", backgroundColor: .blue, borderColor: .blue, isEnabled: true)
    private let shippingOptionsButton = PillButton(title: "Shipping Options", backgroundColor: .blue, borderColor: .blue, isEnabled: true)
    private let payButton = PillButton(title: "Pay", backgroundColor: .blue, borderColor: .blue, isEnabled: true)


    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        paymentOptionsButton.addTarget(self, action: #selector(paymentOptionsButtonTapped), for: .touchUpInside)
        shippingOptionsButton.addTarget(self, action: #selector(shippingOptionsButtonTapped), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)

        buttonsStackView.addArrangedSubview(paymentOptionsButton)
        buttonsStackView.addArrangedSubview(shippingOptionsButton)
        buttonsStackView.addArrangedSubview(payButton)

        addSubviews([paymentTextField, buttonsStackView])
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            paymentTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            paymentTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
        ])

        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: paymentTextField.bottomAnchor, constant: 12.0),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0)
        ])
    }

    // MARK: Action

    @objc private func shippingOptionsButtonTapped() {
        delegate?.shippingOptionsButtonTapped()
    }

    @objc private func paymentOptionsButtonTapped() {
        delegate?.paymentOptionsButtonTapped()
    }

    @objc private func payButtonTapped() {
        delegate?.payButtonTapped()
    //        paymentContext.presentShippingViewController()
    }
//        paypalCheckoutButton.isLoading = true
        //        delegate.checkoutButtonTapped()
        // [server side] - create a payment intent
        // [client side] - confirm the payment intent

        // make a post request to the /create_payment_intent endpoint

//        paymentContext.presentPaymentOptionsViewController()

//        createPaymentIntent(completion: { (paymentIntentResponse, error) in
//            if let error = error {
//                self.paypalCheckoutButton.isLoading = false
//                print(error)
//                return
//            } else {
//                guard let responseDictionary = paymentIntentResponse as? [String: AnyObject] else {
//                    print("Incorrect response")
//                    return
//                }
//
//                let clientSecret = responseDictionary["secret"] as! String
//
//                print("Created payment intent")
//
//                // confirm the PaymentIntent using STPPaymentHandler
//                // implement delegates for STPAuthenticationContext
//
//                let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
//                let params: [String: Any] = [
//                    "metadata": [
//                        // example-ios-backend allows passing metadata through to Stripe
//                        "payment_request_id": "B3E611D1-5FA1-4410-9CEC-00958A5126CB",
//                        "amount": 15498
//                    ],
//                ]
//                paymentIntentParams.
//                let paymentMethodParams = STPPaymentMethodParams(card: self.paymentTextField.cardParams,
//                                                                 billingDetails: nil,
//                                                                 metadata: nil)
//                paymentIntentParams.paymentMethodParams = paymentMethodParams
//
//                STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams,
//                                                          authenticationContext: self) { (status, paymentIntent, error) in
//
//                                                            self.paypalCheckoutButton.isLoading = false
//
//                                                            var resultString = ""
//
//                                                            switch status {
//                                                            case .canceled:
//                                                                resultString = "Payment cancelled"
//                                                            case .failed:
//                                                                resultString = "Payment failed. Please try a different card"
//                                                            case .succeeded:
//                                                                resultString = "Payment successful"
//                                                            @unknown default:
//                                                                break
//                                                            }
//
//                                                            print(resultString)
//
//                }
//
//            }
//        })

//    }

//    private func createPaymentIntent(completion: @escaping STPJSONResponseCompletionBlock) {
//        let url = URL(string: backendURL)!.appendingPathComponent("create_payment_intent")
//
//        Alamofire.request(url,
//                          method: .post,
//                          parameters: [:],
//                          encoding: URLEncoding.httpBody)
//            .validate(statusCode: 200..<300)
//            .responseJSON { (response) in
//                switch response.result {
//                case .failure(let error):
//                    completion(nil, error)
//                case .success(let json):
//                    completion(json as? [String: Any], nil)
//
//                }
//        }
//    }

//    // MARK: STPAuthenticationContextDelegate
//
//    func authenticationPresentingViewController() -> UIViewController {
//        return ctvc
//    }

}
