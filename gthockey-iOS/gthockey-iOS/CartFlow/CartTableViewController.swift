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

class CartTableViewController: UITableViewController {

    // MARK: Properties

    private var cartItems: [CartItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchCart()
    }

    private func setupTableView() {
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cartTableViewCell")
        
        tableView.tableFooterView = CartTableViewFooter()
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
                        var price: Float? = 99.0
                        var attributes: [String : Any]? = [:]
                        for (key, val) in item {
                            switch key {
                            case "id":
                                id = val as? Int
                            case "name":
                                name = val as? String
                            case "imageURL":
                                imageURL = URL(string: val as? String ?? "")
                            case "price":
                                price = val as? Float
                            default:
                                attributes?[key] = val
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
                    print(self.cartItems)
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
            print("Deleted")

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
//            cartItems.remove(at: indexPath.row)
        }
    }

}
