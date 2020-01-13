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

    public func getAllUsers(completion: @escaping ([AppUser], Error?) -> Void) {
        let db = Firestore.firestore()

        db.collection("users").getDocuments { (document, error) in
            guard let documents = document?.documents else { return }

            var appUserArray: [AppUser] = []
            for document in documents {
                if let firstName = ((document.data() as NSDictionary)["firstName"] as! String?),
                    let lastName = ((document.data() as NSDictionary)["lastName"] as! String?),
                    let email = ((document.data() as NSDictionary)["email"] as! String?) {
                    let appUser = AppUser(firstName: firstName, lastName: lastName, email: email)
                    appUserArray.append(appUser)
                }
            }
            completion(appUserArray, nil)
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

}
