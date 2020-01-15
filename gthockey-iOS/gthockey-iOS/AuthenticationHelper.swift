//
//  AuthenticationHelper.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 12/25/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthenticationHelper {

    init() {}

    // MARK: Public Functions

    public func login(with email: String, _ password: String, _ firstName: String?, _ lastName: String?, completion: @escaping (Bool, Error?) -> Void) {
        AdminHelper().saveAdminUsersonLaunch(completion: { _ in
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if let error = error, user == nil {
                    completion(false, error)
                } else {
                    if let user = user?.user, user.isEmailVerified {
                        let db = Firestore.firestore()
                        self.getUserProperties(completion: { propertiesDictionary in
                            let firstName = propertiesDictionary["firstName"] ?? ""
                            let lastName = propertiesDictionary["lastName"] ?? ""
                            let cart = propertiesDictionary["cart"] ?? []

                            let currentDate = Date()
                            let dateStr = DateHelper().formatDate(from: currentDate)
                            let timeStr = DateHelper().formatTime(from: currentDate)

                            db.collection("users").document(user.uid).setData(["firstName": firstName,
                                                                               "lastName": lastName,
                                                                               "email": email,
                                                                               "lastLogin": "\(dateStr) \(timeStr)",
                                                                               "isAdmin": AdminHelper().isAdminUser(email) ? true : false,
                                                                               "uid": user.uid,
                                                                               "cart": cart]) { (error) in
                                if error != nil {
                                    completion(false, error)
                                }
                                self.setUserDefaults(with: email, password: password, isAdmin: true)
                                completion(true, nil)
                            }
                        })
                    } else {
                        completion(false, CustomError.emailVerification)
                    }
                }
            }
        })
    }

    public func createUser(with firstName: String, _ lastName: String, _ email: String,
                       _ password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completion(false, error)
            } else {
                guard let user = result?.user else { return }
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData(["firstName": firstName,
                                                                   "lastName": lastName,
                                                                   "email": email,
                                                                   "isAdmin": AdminHelper().isAdminUser(email) ? true : false,
                                                                   "lastLogin": "No login yet",
                                                                   "uid": user.uid,
                                                                   "cart": []]) { (error) in
                    if error != nil {
                        completion(false, error)
                    }
                }

                if !user.isEmailVerified {
                    user.sendEmailVerification(completion: { error in
                        // Notify the user that the mail has sent or couldn't because of an error
                        completion(true, nil)
                    })
                } else {
                    completion(false, error)
                }
            }
        }
    }

    public func resetPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { error in
            if error != nil {
                completion(error)
            }
            completion(nil)
        })
    }

    public func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "password")
            UserDefaults.standard.removeObject(forKey: "isAdmin")
            UIApplication.shared.unregisterForRemoteNotifications()
            completion(true, nil)
        } catch let error as NSError {
            completion(false, error)
        }
    }

    public func getUserProperties(completion: @escaping ([String : Any]) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                guard let document = document,
                            document.exists
                else { return }

                if let firstName = ((document.data()! as NSDictionary)["firstName"] as! String?),
                    let lastName = ((document.data()! as NSDictionary)["lastName"] as! String?),
                    let email = ((document.data()! as NSDictionary)["email"] as! String?),
                    let cart = ((document.data()! as NSDictionary)["cart"]) {
                    completion(["firstName": firstName, "lastName": lastName, "email": email, "cart": cart])
                }
            }
        }
    }

    public func updateUserProperties(with firstName: String, lastName: String, completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).updateData(["firstName": firstName, "lastName": lastName])
            completion(true)
        }
        completion(false)
    }

    // MARK: Private Functions

    private func setUserDefaults(with email: String, password: String, isAdmin: Bool) {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
    }

}
