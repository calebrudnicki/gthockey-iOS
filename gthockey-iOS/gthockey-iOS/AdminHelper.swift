//
//  AdminHelper.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/12/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AdminHelper {

    init() {}

    // MARK: Public Functions

    public func isAdminUser(_ email: String) -> Bool {
        if email == "calebrudnicki@gmail.com" {
            return true
        }
        return false
//        let db = Firestore.firestore()
//
//        db.collection("adminUsers").getDocuments { (document, error) in
//            guard let documents = document?.documents else { return }
//
//            var emailArray: [String] = []
//            for document in documents {
//                if let currentEmail = ((document.data() as NSDictionary)["email"] as! String?) {
//                    if currentEmail == email {
//                        return true
//                    }
//                }
//            }
//        }
//        return false
    }

    public func getAdminUsers(completion: @escaping ([String], Error?) -> Void) {
        let db = Firestore.firestore()

        db.collection("adminUsers").getDocuments { (document, error) in
            guard let documents = document?.documents else { return }

            var emailArray: [String] = []
            for document in documents {
                if let email = ((document.data() as NSDictionary)["email"] as! String?) {
                    emailArray.append(email)
                }
            }
            completion(emailArray, nil)
        }
    }

    public func add(email: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("adminUsers").addDocument(data: ["email": email]) { (error) in
            if error != nil {
                completion(false)
            }
            completion(true)
        }
    }

//    public func remove(email: String, completion: @escaping (Bool) -> Void) {
//        let db = Firestore.firestore()
//        db.collection("adminUsers").getDocument { (document, error) in
//            guard let documents = document?.documents else { return }
//
//
//            db.collection("adminUsers").document(user.uid).updateData([
//                "cart": FieldValue.arrayRemove([item]),
//            ]) { error in
//                if let error = error {
//                    print("Error updating document: \(error)")
//                } else {
//                    print("Document successfully updated")
//                }
//            }
//            completion(true)
////            var emailArray: [String] = []
//            for document in documents {
//                if let email = ((document.data() as NSDictionary)["email"] as! String?) {
////                    emailArray.append(email)
//                    db.collection("users").document(user.uid).updateData([
//                        "cart": FieldValue.arrayRemove([item]),
//                    ]) { error in
//                        if let error = error {
//                            print("Error updating document: \(error)")
//                        } else {
//                            print("Document successfully updated")
//                        }
//                    }
//                    completion(true)
//                }
//            }
//            completion(emailArray, nil)
//
//
//            if let document = document, document.exists {
//                let data = document.data()! as [String : Any]
//                let cart = data["cart"] as! [[String : Any]]
//                for item in cart {
//                    let tempCartItem = CartItem(id: item["id"] as! Int,
//                                                name: item["name"] as! String,
//                                                imageURL: URL(fileURLWithPath: item["imageURL"] as! String),
//                                                price: item["price"] as! Double,
//                                                attributes: item["attributes"] as! [String: Any])
//
//                    if tempCartItem == cartItem {
//                        db.collection("users").document(user.uid).updateData([
//                            "cart": FieldValue.arrayRemove([item]),
//                        ]) { error in
//                            if let error = error {
//                                print("Error updating document: \(error)")
//                            } else {
//                                print("Document successfully updated")
//                            }
//                        }
//                        completion(true)
//                    }
//                }
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }

}
