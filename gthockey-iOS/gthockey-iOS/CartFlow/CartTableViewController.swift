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

class CartTableViewController: UITableViewController {

    // MARK: Properties

    var stpTheme: STPTheme {
        let theme = STPTheme.init()
        theme.primaryBackgroundColor = UIColor(red:230.0/255.0, green:235.0/255.0, blue:241.0/255.0, alpha:255.0/255.0)
        theme.secondaryBackgroundColor = UIColor.white
        theme.primaryForegroundColor = UIColor(red:55.0/255.0, green:53.0/255.0, blue:100.0/255.0, alpha:255.0/255.0)
        theme.secondaryForegroundColor = UIColor(red:148.0/255.0, green:163.0/255.0, blue:179.0/255.0, alpha:255.0/255.0)
        theme.accentColor = UIColor(red:101.0/255.0, green:101.0/255.0, blue:232.0/255.0, alpha:255.0/255.0)
        theme.errorColor = UIColor(red:240.0/255.0, green:2.0/255.0, blue:36.0/255.0, alpha:255.0/255.0)
        #if canImport(CryptoKit)
        if #available(iOS 13.0, *) {
            theme.primaryBackgroundColor = UIColor.init(dynamicProvider: { (tc) -> UIColor in
                return (tc.userInterfaceStyle == .light) ?
                    UIColor(red:230.0/255.0, green:235.0/255.0, blue:241.0/255.0, alpha:255.0/255.0) :
                    UIColor(red:66.0/255.0, green:69.0/255.0, blue:112.0/255.0, alpha:255.0/255.0)
            })
            theme.secondaryBackgroundColor = UIColor.init(dynamicProvider: { (tc) -> UIColor in
                return (tc.userInterfaceStyle == .light) ?
                    .white : theme.primaryBackgroundColor
            })
            theme.primaryForegroundColor = UIColor.init(dynamicProvider: { (tc) -> UIColor in
                return (tc.userInterfaceStyle == .light) ?
                    UIColor(red:55.0/255.0, green:53.0/255.0, blue:100.0/255.0, alpha:255.0/255.0) :
                    .white
            })
            theme.secondaryForegroundColor = UIColor.init(dynamicProvider: { (tc) -> UIColor in
                return (tc.userInterfaceStyle == .light) ?
                    UIColor(red:148.0/255.0, green:163.0/255.0, blue:179.0/255.0, alpha:255.0/255.0) :
                    UIColor(red:130.0/255.0, green:147.0/255.0, blue:168.0/255.0, alpha:255.0/255.0)
            })
            theme.accentColor = UIColor.init(dynamicProvider: { (tc) -> UIColor in
                return (tc.userInterfaceStyle == .light) ?
                    UIColor(red:101.0/255.0, green:101.0/255.0, blue:232.0/255.0, alpha:255.0/255.0) :
                    UIColor(red:14.0/255.0, green:211.0/255.0, blue:140.0/255.0, alpha:255.0/255.0)
            })
            theme.errorColor = UIColor.init(dynamicProvider: { (tc) -> UIColor in
                return (tc.userInterfaceStyle == .light) ?
                    UIColor(red:240.0/255.0, green:2.0/255.0, blue:36.0/255.0, alpha:255.0/255.0) :
                    UIColor(red:237.0/255.0, green:83.0/255.0, blue:69.0/255.0, alpha:255.0/255.0)
            })
        } else {
            theme.primaryBackgroundColor = UIColor(red:230.0/255.0, green:235.0/255.0, blue:241.0/255.0, alpha:255.0/255.0)
            theme.secondaryBackgroundColor = UIColor.white
            theme.primaryForegroundColor = UIColor(red:55.0/255.0, green:53.0/255.0, blue:100.0/255.0, alpha:255.0/255.0)
            theme.secondaryForegroundColor = UIColor(red:148.0/255.0, green:163.0/255.0, blue:179.0/255.0, alpha:255.0/255.0)
            theme.accentColor = UIColor(red:101.0/255.0, green:101.0/255.0, blue:232.0/255.0, alpha:255.0/255.0)
            theme.errorColor = UIColor(red:240.0/255.0, green:2.0/255.0, blue:36.0/255.0, alpha:255.0/255.0)
        }
        #endif
        return theme
    }

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
        cartTableViewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150.0)
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
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }

}

extension CartTableViewController: CartTableViewFooterDelegate {

    func checkoutButtonTapped() {
        let addCardViewController = STPAddCardViewController()
        let addCardNavigationController = UINavigationController(rootViewController: addCardViewController)
        addCardViewController.delegate = self
        present(addCardNavigationController, animated: true, completion: nil)
    }

    func shippingButtonTapped() {
        let config = STPPaymentConfiguration()
        config.requiredShippingAddressFields = [.postalAddress]
        let viewController = STPShippingAddressViewController(configuration: config,
                                                              theme: stpTheme,
                                                              currency: "usd",
                                                              shippingAddress: nil,
                                                              selectedShippingMethod: nil,
                                                              prefilledInformation: nil)
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
//        let shippingAddressViewController = STPShippingAddressViewController()
//        let shippingAddressNavigationController = UINavigationController(rootViewController: shippingAddressViewController)
//        shippingAddressViewController.delegate = self
//        present(shippingAddressNavigationController, animated: true, completion: nil)
    }

}

extension CartTableViewController: STPAddCardViewControllerDelegate {

    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true, completion: nil)
    }

    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {

        var totalPrice = 0.0
        for item in cartItems {
            totalPrice += item.getPrice()
        }

        StripeClient.shared.completeCharge(with: token, amount: totalPrice) { result in
            self.dismiss(animated: true, completion: nil)

            switch result {
            case .success:
                completion(nil)

                let cartHelper = CartHelper()
                cartHelper.clearCart(completion: { result in
                    if result {
                        print("Successfully cleared cart")
                        self.cartItems = []
                        self.tableView.reloadData()
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Could not clear cart")
                    }
                })

                let alertController = UIAlertController(title: "Congrats", message: "Your payment was successful!", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true)
            case .failure(let error):
                completion(error)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension CartTableViewController: STPShippingAddressViewControllerDelegate {

    func shippingAddressViewControllerDidCancel(_ addressViewController: STPShippingAddressViewController) {
        dismiss(animated: true, completion: nil)
    }

    func shippingAddressViewController(_ addressViewController: STPShippingAddressViewController, didEnter address: STPAddress, completion: @escaping STPShippingMethodsCompletionBlock) {
        print("Giu")
        StripeClient.shared.addAddress(with: address)
    }

    func shippingAddressViewController(_ addressViewController: STPShippingAddressViewController, didFinishWith address: STPAddress, shippingMethod method: PKShippingMethod?) {
        print("Hwuef")
    }

}
