//
//  AdminManager.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class AdminManager {
//
//    // MARK: Properties
//
//    private static var adminUsersOnAppLaunch: [String] = []
//
//    // MARK: Init
//
//    init() {}
//
//    // MARK: Public Functions
//
//    /**
//     Determines if the user in question is an admin user.
//
//     - Returns: A `Bool` indication of if the user is an admin.
//     */
//    public func isAdminUser(_ email: String) -> Bool {
//        return AdminManager.adminUsersOnAppLaunch.contains(email)
//    }
//
//    /**
//     Saves all of the admin app users when the application is launched.
//     */
//    public func saveAdminUsersOnLaunch() {
//        AdminManager.self.adminUsersOnAppLaunch = []
//
//        Firestore.firestore().collection("adminUsers").getDocuments { (document, error) in
//            guard let documents = document?.documents else { return }
//
//            for document in documents {
//                if let email = ((document.data() as NSDictionary)["email"] as! String?) {
//                    AdminManager.self.adminUsersOnAppLaunch.append(email)
//                }
//            }
//        }
//    }
//
//    /**
//     Retrieves the list of all admin users.
//
//     - Parameter completion: A block to execute once the admin users are retrieved.
//     */
//    public func getAdminUsers(completion: @escaping ([String], Error?) -> Void) {
//        Firestore.firestore().collection("adminUsers").getDocuments { (document, error) in
//            guard let documents = document?.documents else { return }
//
//            var emailArray: [String] = []
//            for document in documents {
//                if let email = ((document.data() as NSDictionary)["email"] as! String?) {
//                    emailArray.append(email)
//                }
//            }
//            completion(emailArray, nil)
//        }
//    }
//
//    /**
//     Adds a user to the list of admin users.
//
//     - Parameter email: A `String` representation of the new admin user's email address.
//     - Parameter completion: A block to execute once the admin user is added.
//     */
//    public func add(_ email: String, completion: @escaping (Bool) -> Void) {
//        Firestore.firestore().collection("adminUsers").addDocument(data: ["email": email]) { (error) in
//            if error != nil {
//                completion(false)
//            }
//            completion(true)
//        }
//    }
//
//    /**
//     Removes a user from the list of admin users.
//
//     - Parameter adminEmail: A `String` representation of the admin user's email address.
//     - Parameter completion: A block to execute once the admin users is deleted.
//     */
//    public func remove(_ adminEmail: String, completion: @escaping (Bool) -> Void) {
//        Firestore.firestore().collection("adminUsers").getDocuments { (document, error) in
//            guard let documents = document?.documents else { return }
//
//            for document in documents {
//                if let email = ((document.data() as NSDictionary)["email"] as! String?) {
//                    if email == adminEmail {
//                        Firestore.firestore().collection("adminUsers").document(document.documentID).delete()
//                        completion(true)
//                        return
//                    }
//                }
//            }
//            completion(false)
//        }
//    }
//
//}
