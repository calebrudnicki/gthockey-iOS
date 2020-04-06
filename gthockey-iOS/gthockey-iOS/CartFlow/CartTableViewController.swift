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
//import Stripe

// MARK: Under Construction (not used)

class CartTableViewController: UITableViewController {

//    // MARK: Properties
//
//    private var cartItems: [CartItem] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupTableView()
//        fetchCart()
//    }
//
//    private func setupTableView() {
//        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cartTableViewCell")
//
//        let cartTableViewFooter = CartTableViewFooter()
//        cartTableViewFooter.delegate = self
//        cartTableViewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 75.0)
//        tableView.tableFooterView = cartTableViewFooter
//    }
//
//    @objc private func fetchCart() {
//        let cartHelper = CartHelper()
//        cartHelper.retrieveCart(completion: { (retrievedItems, error) in
//            if let error = error as NSError? {
//                print(error.localizedDescription)
//            }
//            self.cartItems = retrievedItems
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        })
//    }
//
//    // MARK: Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cartItems.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! CartTableViewCell
//        cell.set(with: cartItems[indexPath.row])
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 148.0
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let cartHelper = CartHelper()
//            cartHelper.remove(with: cartItems[indexPath.row], completion: { result in
//                if result {
//                    self.cartItems.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                } else {
//                    let alert = UIAlertController(title: "Remove to Cart Failed",
//                                                  message: nil,
//                                                  preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true, completion: nil)
//                }
//            })
//        }
//    }
//
//}
//
//extension CartTableViewController: CartTableViewFooterDelegate {
//
//    func checkoutButtonTapped() {
//        let addCardViewController = STPAddCardViewController()
//        let addCardNavigationViewController = UINavigationController(rootViewController: addCardViewController)
//        addCardViewController.delegate = self
//        present(addCardNavigationViewController, animated: true, completion: nil)
//    }
//
//}
//
//extension CartTableViewController: STPAddCardViewControllerDelegate {
//
//    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
//
//        var totalPrice = 0.0
//        for item in cartItems {
//            totalPrice += item.getPrice()
//        }
//
//        StripeManager.shared.completeCharge(with: token, amount: totalPrice) { result in
//            self.dismiss(animated: true, completion: nil)
//
//            switch result {
//            case .success:
//                completion(nil)
//
//                let cartHelper = CartHelper()
//                cartHelper.clearCart(completion: { result in
//                    if result {
//                        print("Successfully cleared cart")
//                        self.cartItems = []
//                        self.tableView.reloadData()
//                        self.dismiss(animated: true, completion: nil)
//                    } else {
//                        print("Could not clear cart")
//                    }
//                })
//
//                let alertController = UIAlertController(title: "Congrats", message: "Your payment was successful!", preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                alertController.addAction(alertAction)
//                self.present(alertController, animated: true)
//            case .failure(let error):
//                completion(error)
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
    
}
