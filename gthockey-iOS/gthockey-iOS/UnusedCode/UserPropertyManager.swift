//
//  UserPropertyManager.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class UserPropertyManager {
//
//    // MARK: Init
//
//    init() {}
//
//    // MARK: Public Functions
//
//    /// Returns the unique identifier of the current user
//    public var id: String? {
//        guard let user = Auth.auth().currentUser else { return nil }
//        return user.uid
//    }
//
//    /// Returns the name of the current user
//    public var displayName: String? {
//        guard let user = Auth.auth().currentUser else { return nil }
//        return user.displayName
//    }
//
//    /// Returns the email of the current user
//    public var email: String? {
//        guard let user = Auth.auth().currentUser else { return nil }
//        return user.email
//    }
//
//    /**
//     Fetches and returns a dictionary holding all properties for a particular user.
//
//     - Parameter uid: The unique identifier to represent the targeted user.
//     - Parameter completion: A block to execute once the user's properties have been retrieved.
//     */
//    public func getAllPropertiesForUser(for uid: String, completion: @escaping ([String : Any]) -> Void) {
//        Firestore.firestore().collection("users").document(uid).getDocument { (document, error) in
//            guard let document = document, document.exists else { return }
//
//            completion(["firstName": document["firstName"] as? String ?? "",
//                        "lastName": document["lastName"] as? String ?? "",
//                        "email": document["email"] as? String ?? "",
//                        "appIcon": document["appIcon"] as? String ?? "",
//                        "fcmToken": document["fcmToken"] as? String ?? "",
//                        "versionNumber": document["versionNumber"] as? String ?? "",
//                        "cart": document["cart"] as? String ?? []
//            ])
//        }
//    }
//
//    /**
//     Fetches and returns a dictionary holding all properties for the current user.
//
//     - Parameter completion: A block to execute once the user's properties have been retrieved.
//     */
//    public func getAllPropertiesForCurrentUser(completion: @escaping ([String : Any]) -> Void) {
//        guard let user = Auth.auth().currentUser else { return }
//
//        Firestore.firestore().collection("users").document(user.uid).getDocument { (document, error) in
//            guard let document = document, document.exists else { return }
//
//            completion(["firstName": document["firstName"] as? String ?? "",
//                        "lastName": document["lastName"] as? String ?? "",
//                        "email": document["email"] as? String ?? "",
//                        "appIcon": document["appIcon"] as? String ?? "",
//                        "fcmToken": document["fcmToken"] as? String ?? "",
//                        "versionNumber": document["versionNumber"] as? String ?? "",
//                        "cart": document["cart"] as? String ?? []
//            ])
//        }
//    }
//
//    /**
//     Overrides a particular set of user properties in the database for one user.
//
//     - Parameter dict: A dictionary representation of the user property or properties to override and the corresponding
//     values to override them with (i.e. using `dict = ["firstName": "George"]` will make the selected user's `firstName`
//     = "George".
//     - Parameter uid: The unique identifier to represent the targeted user.
//     - Parameter completion: A block to execute once the user property or properties have been overriden.
//     */
//    public func overrideForOneUser(with dict: [String: Any], for uid: String, completion: @escaping () -> Void) {
//        Firestore.firestore().collection("users").document(uid).getDocument { (document, error) in
//            guard let document = document, document.exists else { return }
//
//            for (key, val) in dict {
//                document.reference.setData([key: val], merge: true)
//            }
//            completion()
//        }
//    }
//
//    /**
//     Overrides a particular set of user properties in the database for the current user.
//
//     - Parameter dict: A dictionary representation of the user property or properties to override and the corresponding
//     values to override them with (i.e. using `dict = ["firstName": "George"]` will make the current user's `firstName`
//     = "George".
//     - Parameter completion: A block to execute once the user property or properties have been overriden.
//     */
//    public func overrideForCurrentUser(with dict: [String: Any], completion: @escaping () -> Void) {
//        guard let user = Auth.auth().currentUser else { return }
//
//        Firestore.firestore().collection("users").document(user.uid).updateData(dict)
//        completion()
//    }
//
//    /**
//     Overrides a particular set of user properties in the database for all users.
//
//     - Parameter dict: A dictionary representation of the user property or properties to override and the corresponding
//     values to override them with (i.e. using `dict = ["firstName": "George"]` will make all user's `firstName`
//     = "George".
//     - Parameter completion: A block to execute once the user property or properties have been overriden.
//     */
//    public func overrideForAllUsers(with dict: [String: Any], completion: @escaping () -> Void) {
//        Firestore.firestore().collection("users").getDocuments { (document, error) in
//            guard let documents = document?.documents else { return }
//
//            for document in documents {
//                for (key, val) in dict {
//                    document.reference.setData([key: val], merge: true)
//                }
//            }
//            completion()
//        }
//    }
//
//}
