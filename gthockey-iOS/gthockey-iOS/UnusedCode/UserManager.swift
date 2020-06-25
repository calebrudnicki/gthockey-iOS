//
//  UserManager.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class UserManager {
//
//    // MARK: Init
//
//    init() {}
//
//    // MARK: Public Functions
//
//    /**
//    Fetches and returns a list of all users registered for your application.
//
//    - Parameter completion: A block to execute once the user's properties have been retrieved.
//    */
//    public func getAllUsers(completion: @escaping ([AppUser]) -> Void) {
//        Firestore.firestore().collection("users").getDocuments { (document, error) in
//            guard let documents = document?.documents else { return }
//
//            var appUsers: [AppUser] = []
//
//            for document in documents {
//                let appUser = AppUser(firstName: document["firstName"] as? String ?? "No first name",
//                                      lastName: document["lastName"] as? String ?? "No last name",
//                                      email: document["email"] as? String ?? "No email",
//                                      fcmToken: document["fcmToken"] as? String ?? "No FCM token",
//                                      lastLogin: document["lastLogin"] as? String ?? "No last login",
//                                      isAdmin: document["isAdmin"] as? Bool ?? false,
//                                      appVersion: document["versionNumber"] as? String ?? "No app version",
//                                      uid: document["uid"] as? String ?? "No uid")
//                appUsers.append(appUser)
//            }
//            completion(appUsers)
//        }
//    }
//
//    /**
//     Fetches and returns a list of all users registered for your application.
//
//     - Parameter completion: A block to execute once the user's properties have been retrieved.
//     */
//    public func getAllUsersWithValidFCMToken(completion: @escaping ([AppUser]) -> Void) {
//        Firestore.firestore().collection("users").getDocuments { (document, error) in
//            guard let documents = document?.documents else { return }
//
//            var appUsersWithValidFCMToken: [AppUser] = []
//
//            for document in documents {
//                if let firstName = ((document.data() as NSDictionary)["firstName"] as! String?),
//                    let lastName = ((document.data() as NSDictionary)["lastName"] as! String?),
//                    let email = ((document.data() as NSDictionary)["email"] as! String?),
//                    let fcmToken = ((document.data() as NSDictionary)["fcmToken"] as! String?),
//                    let lastLogin = ((document.data() as NSDictionary)["lastLogin"] as! String?),
//                    let isAdmin = ((document.data() as NSDictionary)["isAdmin"] as! Bool?),
//                    let appVersion = ((document.data() as NSDictionary)["versionNumber"] as! String?),
//                    let uid = ((document.data() as NSDictionary)["uid"] as! String?) {
//
//                        if fcmToken != "" && fcmToken.lowercased() != "no fcm token" {
//                            let appUser = AppUser(firstName: firstName, lastName: lastName, email: email,
//                                                  fcmToken: fcmToken, lastLogin: lastLogin, isAdmin: isAdmin,
//                                                  appVersion: appVersion, uid: uid)
//                            appUsersWithValidFCMToken.append(appUser)
//                        }
//                }
//            }
//            completion(appUsersWithValidFCMToken)
//        }
//    }
//
//}
