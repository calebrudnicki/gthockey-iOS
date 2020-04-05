//
//  CartTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/15/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Stripe

// MARK: Under Construction (not used)

class CartTableViewController: UITableViewController {

    // MARK: Properties

    private var cartItems: [CartItem] = []
    let customerContext = STPCustomerContext(keyProvider: StripeClient())
    private var paymentContext = STPPaymentContext()

    override func viewDidLoad() {
        super.viewDidLoad()

        paymentContext = STPPaymentContext(customerContext: customerContext)
        paymentContext.delegate = self
        paymentContext.hostViewController = self
        paymentContext.paymentAmount = 15498

        setupTableView()
        fetchCart()
    }

    private func setupTableView() {
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cartTableViewCell")

        let cartTableViewFooter = CartTableViewFooter()
        cartTableViewFooter.delegate = self
        cartTableViewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 125.0)
        tableView.tableFooterView = cartTableViewFooter
    } 

    @objc private func fetchCart() {
        let cartHelper = CartHelper()
        cartHelper.retrieveCart(completion: { (retrievedItems, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
            self.cartItems = retrievedItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.set(with: cartItems[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148.0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cartHelper = CartHelper()
            cartHelper.remove(with: cartItems[indexPath.row], completion: { result in
                if result {
                    self.cartItems.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                } else {
                    let alert = UIAlertController(title: "Remove to Cart Failed",
                                                  message: nil,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }

}

extension CartTableViewController: CartTableViewFooterDelegate {

    func shippingOptionsButtonTapped() {
        paymentContext.presentShippingViewController()
    }

    func paymentOptionsButtonTapped() {
        paymentContext.presentPaymentOptionsViewController()
    }

    func payButtonTapped() {
        paymentContext.requestPayment()
    }

}

extension CartTableViewController: STPPaymentContextDelegate {

    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        print("1")
    }

    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        print("2")
        StripeClient.shared.createPaymentIntent(products: cartItems, shippingMethod: paymentContext.selectedShippingMethod) { result in
            switch result {
            case .success(let clientSecret):
                // Assemble the PaymentIntent parameters
                let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
                paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId

                // Confirm the PaymentIntent
                STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: paymentContext) { status, paymentIntent, error in
                    switch status {
                    case .succeeded:
                        // Your backend asynchronously fulfills the customer's order, e.g. via webhook
                        completion(.success, nil)
                    case .failed:
                        completion(.error, error) // Report error
                    case .canceled:
                        completion(.userCancellation, nil) // Customer cancelled
                    @unknown default:
                        completion(.error, nil)
                    }
                }
            case .failure(let error):
                completion(.error, error) // Report error from your API
                break
            }
        }
    }

    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        print("3")
        switch status {
        case .error:
            print(error?.localizedDescription)
        case .success:
            print("success")
        case .userCancellation:
            return // Do nothing
        }
    }

    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        print("4")
    }

    func paymentContext(_ paymentContext: STPPaymentContext, didUpdateShippingAddress address: STPAddress, completion: @escaping STPShippingMethodsCompletionBlock) {
        let upsGround = PKShippingMethod()
        upsGround.amount = 0
        upsGround.label = "UPS Ground"
        upsGround.detail = "Arrives in 3-5 days"
        upsGround.identifier = "ups_ground"
        let fedEx = PKShippingMethod()
        fedEx.amount = 5.99
        fedEx.label = "FedEx"
        fedEx.detail = "Arrives tomorrow"
        fedEx.identifier = "fedex"

        if address.country == "US" {
            completion(.valid, nil, [upsGround, fedEx], upsGround)
        }
        else {
            completion(.invalid, nil, nil, nil)
        }
    }

}
