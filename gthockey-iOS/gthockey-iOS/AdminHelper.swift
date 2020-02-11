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

    // MARK: Properties

    private static var adminUsersOnAppLaunch: [String] = []

    // MARK: Public Functions

    public func getAllUsers(completion: @escaping ([AppUser], [AppUser], Error?) -> Void) {
        let db = Firestore.firestore()

        db.collection("users").getDocuments { (document, error) in
            guard let documents = document?.documents else { return }

            var appUserWithLastLoginArray: [AppUser] = []
            var appUserWithoutLastLoginArray: [AppUser] = []

            for document in documents {
                if let firstName = ((document.data() as NSDictionary)["firstName"] as! String?),
                    let lastName = ((document.data() as NSDictionary)["lastName"] as! String?),
                    let email = ((document.data() as NSDictionary)["email"] as! String?),
                    let fcmToken = ((document.data() as NSDictionary)["fcmToken"] as! String?),
                    let lastLogin = ((document.data() as NSDictionary)["lastLogin"] as! String?),
                    let isAdmin = ((document.data() as NSDictionary)["isAdmin"] as! Bool?) {

                    let appUser = AppUser(firstName: firstName, lastName: lastName, email: email,
                                          fcmToken: fcmToken, lastLogin: lastLogin, isAdmin: isAdmin)

                    if lastLogin == "No login yet" {
                        appUserWithoutLastLoginArray.append(appUser)
                    } else {
                        appUserWithLastLoginArray.append(appUser)
                    }
                }
            }
            completion(appUserWithLastLoginArray, appUserWithoutLastLoginArray, nil)
        }
    }

    public func getAllUsersWithValidFCMToken(completion: @escaping ([AppUser], Error?) -> Void) {
        let db = Firestore.firestore()

        db.collection("users").getDocuments { (document, error) in
            guard let documents = document?.documents else { return }

            var appUsersWithValidFCMToken: [AppUser] = []

            for document in documents {
                if let firstName = ((document.data() as NSDictionary)["firstName"] as! String?),
                    let lastName = ((document.data() as NSDictionary)["lastName"] as! String?),
                    let email = ((document.data() as NSDictionary)["email"] as! String?),
                    let fcmToken = ((document.data() as NSDictionary)["fcmToken"] as! String?),
                    let lastLogin = ((document.data() as NSDictionary)["lastLogin"] as! String?),
                    let isAdmin = ((document.data() as NSDictionary)["isAdmin"] as! Bool?) {

                    if fcmToken != "" && fcmToken.lowercased() != "no fcm token" {
                        let appUser = AppUser(firstName: firstName, lastName: lastName, email: email,
                        fcmToken: fcmToken, lastLogin: lastLogin, isAdmin: isAdmin)
                        appUsersWithValidFCMToken.append(appUser)
                    }
                }
            }
            completion(appUsersWithValidFCMToken, nil)
        }
    }

    public func isAdminUser(_ email: String) -> Bool {
        return AdminHelper.adminUsersOnAppLaunch.contains(email)
    }

    public func saveAdminUsersonLaunch(completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()

        AdminHelper.self.adminUsersOnAppLaunch = []

        db.collection("adminUsers").getDocuments { (document, error) in
            guard let documents = document?.documents else { return }

            for document in documents {
                if let email = ((document.data() as NSDictionary)["email"] as! String?) {
                    AdminHelper.self.adminUsersOnAppLaunch.append(email)
                }
            }
            completion(true)
        }
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

    public func remove(_ adminEmail: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("adminUsers").getDocuments { (document, error) in
            guard let documents = document?.documents else { return }

            for document in documents {
                if let email = ((document.data() as NSDictionary)["email"] as! String?) {
                    if email == adminEmail {
                        db.collection("adminUsers").document(document.documentID).delete()
                        completion(true)
                        return
                    }
                }
            }
            completion(false)
        }
    }

    public func setForAllUsers(category: String, value: String, nilValues: [String], completion: @escaping () -> Void) {
        let db = Firestore.firestore()

        db.collection("users").getDocuments { (document, error) in
            guard let documents = document?.documents else { return }
            for document in documents {
                if document.data()[category] == nil || !nilValues.contains(document.data()[category] as? String ?? "") {
                    document.reference.setData([category: value], merge: true)
                }
            }
            completion()
        }
    }

}
