//
//  CartManager.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CartManager {

    // MARK: Init

    init() {}

    // MARK: Public Functions

    /**
     Retrieves all of the items in the current user's cart.

     - Parameter completion: A block to execute once the user's cart is retrieved.
     */
    public func retrieveCart(completion: @escaping ([CartItem], Error?) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                if let document = document, document.exists,
                    let cart = ((document.data()! as NSDictionary)["cart"] as! [[String : Any]]?) {
                    var cartItems: [CartItem] = []
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

                        cartItems.append(cartItem)
                    }
                    completion(cartItems, nil)
                } else {
                    completion([], error!)
                }

            }
        }
    }

    /**
     Adds a a merchandise item to a user's cart.

     - Parameter cartDict: A `[String : Any]` representation of the merchandise item that is to be added to the cart.
     - Parameter completion: A block to execute once the item is added.
     */
    public func add(cartDict: [String: Any], completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).updateData(["cart": FieldValue.arrayUnion([cartDict])])
            completion(true)
        }
        completion(false)
    }

    /**
     Removes a single item from the current user's cart.

     - Parameter cartItem: A `CartItem` representation of merchandise item that is to be removed.
     - Parameter completion: A block to execute once the item is removed from the cart.
     */
    public func remove(with cartItem: CartItem, completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()! as [String : Any]
                    let cart = data["cart"] as! [[String : Any]]
                    for item in cart {
                        let tempCartItem = CartItem(id: item["id"] as! Int,
                                                    name: item["name"] as! String,
                                                    imageURL: URL(fileURLWithPath: item["imageURL"] as! String),
                                                    price: item["price"] as! Double,
                                                    attributes: item["attributes"] as! [String: Any])

                        if tempCartItem == cartItem {
                            db.collection("users").document(user.uid).updateData([
                                "cart": FieldValue.arrayRemove([item]),
                            ]) { error in
                                if let error = error {
                                    print("Error updating document: \(error)")
                                } else {
                                    print("Document successfully updated")
                                }
                            }
                            completion(true)
                        }
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }

    /**
     Clears all of the mercandise items within the current user's cart.

     - Parameter completion: A block to execute once the admin user is cleared.
     */
    public func clearCart(completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).updateData(["cart": [:]])
            completion(true)
        }
        completion(false)
    }

}
