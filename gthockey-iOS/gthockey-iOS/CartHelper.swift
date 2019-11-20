//
//  CartHelper.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/19/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CartHelper {

    init() {}

    // MARK: Public Functions

    public func add(cartDict: [String: Any], completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).updateData(["cart": FieldValue.arrayUnion([cartDict])])
            completion(true)
        }
        completion(false)
    }

    public func remove(with cartItem: CartItem, completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()! as [String : Any]
                    let cart = data["cart"] as! [[String : Any]]
                    for item in cart {
                        print(item)
//                        if item["name"] as! String == cartItem.getName() {
//                            db.collection("users").document(user.uid).
//                        }
                    }
//                    print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
        }
    }

}
