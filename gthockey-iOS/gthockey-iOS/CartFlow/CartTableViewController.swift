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
import Braintree
import BraintreeDropIn

class CartTableViewController: UITableViewController, BTAppSwitchDelegate, BTViewControllerPresentingDelegate {
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        print("hhi")
    }

    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        print("hi")
    }

    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        print("bie")
    }

    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        print("bie")
    }

    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        print("jfienfiw")
    }


    // MARK: Properties

    var braintreeClient: BTAPIClient?

    private var cartItems: [CartItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchCart()
    }

    private func setupTableView() {
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cartTableViewCell")

        let cartTableViewFooter = CartTableViewFooter()
        cartTableViewFooter.delegate = self
        cartTableViewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 75.0)
        tableView.tableFooterView = cartTableViewFooter
    }

    @objc private func fetchCart() {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                if let document = document, document.exists,
                    let cart = ((document.data()! as NSDictionary)["cart"] as! [[String : Any]]?) {
                    for item in cart {
                        var id: Int?
                        var name: String?
                        var imageURL: URL?
                        var price: Double?
                        var attributes: [String : Any]?
                        for (key, val) in item {
                            switch key {
                            case "id":
                                id = val as? Int
                            case "name":
                                name = val as? String
                            case "imageURL":
                                imageURL = URL(string: val as? String ?? "")
                            case "price":
                                price = val as? Double
                            case "attributes":
                                attributes = val as? [String: Any]
                            default:
                                break
                            }
                        }
                        let cartItem = CartItem(id: id ?? 0,
                                                name: name ?? "",
                                                imageURL: imageURL ?? URL(string: "")!,
                                                price: price ?? 0.0,
                                                attributes: attributes ?? [:])
                        self.cartItems.append(cartItem)
                    }
                } else {
                    print("Document does not exist")
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
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
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }

}

extension CartTableViewController: CartTableViewFooterDelegate {

    func checkoutButtonTapped() {
        var totalPrice = 0.0
        for item in cartItems {
            totalPrice += item.getPrice()
        }
        startCheckout(with: totalPrice)
    }

    func startCheckout(with price: Double) {
        // Example: Initialize BTAPIClient, if you haven't already
        braintreeClient = BTAPIClient(authorization: "sandbox_jy5zxxfm_ggjptv8jy69yxx4p")!
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self // Optional

        let request = BTPayPalRequest(amount: "$" + String(format: "%.2f", price))
        request.currencyCode = "USD"

        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                // Access additional information
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone

                // See BTPostalAddress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
                print("\(firstName) \(lastName) made an order")
            } else if let error = error {
                print(error.localizedDescription)
            } else {
                print("Buyer cancelled payment")
            }
        }
    }

//    func showDropIn(clientTokenOrTokenizationKey: String) {
//        let request =  BTDropInRequest()
//        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request) { (controller, result, error) in
//            if error != nil {
//                print("ERROR")
//            } else if result?.isCancelled == true {
//                print("CANCELLED")
//            } else if let result = result {
//                // Use the BTDropInResult properties to update your UI
//                 print(result.paymentOptionType)
//                 print(result.paymentMethod)
//                 print(result.paymentIcon)
//                 print(result.paymentDescription)
//            }
//            controller.dismiss(animated: true, completion: nil)
//        }
//        self.present(dropIn!, animated: true, completion: nil)
//    }


}
