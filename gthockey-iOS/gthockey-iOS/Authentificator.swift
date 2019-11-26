//
//  Authentificator.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/6/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class Authentificator {

    init() {}

    // MARK: Public Functions

    public func login(with email: String, _ password: String, _ firstName: String?, _ lastName: String?, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                completion(false, error)
            } else {
                if let user = user?.user, user.isEmailVerified {
                    let db = Firestore.firestore()
                    guard
                        let firstName = firstName,
                        let lastName = lastName
                    else {
                        self.getUserProperties(completion: { propertiesDictionary in
                            let firstName = propertiesDictionary["firstName"] ?? ""
                            let lastName = propertiesDictionary["lastName"] ?? ""

                            db.collection("users").document(user.uid).setData(["firstName": firstName,
                                                                               "lastName": lastName,
                                                                               "email": email,
                                                                               "uid": user.uid]) { (error) in
                                if error != nil {
                                    completion(false, error)
                                }
                                completion(true, nil)
                            }
                        })
                        return
                    }
                    db.collection("users").document(user.uid).setData(["firstName": firstName,
                                                                       "lastName": lastName,
                                                                       "email": email,
                                                                       "uid": user.uid]) { (error) in
                        if error != nil {
                            completion(false, error)
                        }
                    }
                    self.setUserDefaults(with: email, password: password)
                    completion(true, nil)
                } else {
                    completion(false, CustomError.emailVerification)
                }
            }
        }
    }

    public func signup(with firstName: String, _ lastName: String, _ email: String,
                       _ password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completion(false, error)
            } else {
                guard let user = result?.user else { return }
                if !user.isEmailVerified {
                    user.sendEmailVerification(completion: { error in
                        // Notify the user that the mail has sent or couldn't because of an error
                        completion(true, nil)
                    })
                } else {
                    // Either the user is not available, or the user is already verified.
//                    db.collection("users").document(user.uid).setData(["firstName": firstName,
//                                                                       "lastName": lastName,
//                                                                       "email": email,
//                                                                       "uid": result?.user.uid ?? email { (error) in
//                        if error != nil {
//                            completion(false, error)
//                        }
//                        self.setUserDefaults(with: email, password: password)
//                    }
                    completion(true, nil)
                }
            }
        }
    }

    public func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "password")
            completion(true, nil)
        } catch let error as NSError {
            completion(false, error)
        }
    }

    public func getUserProperties(completion: @escaping ([String : String]) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                guard let document = document,
                            document.exists
                else { return }

                if let firstName = ((document.data()! as NSDictionary)["firstName"] as! String?),
                    let lastName = ((document.data()! as NSDictionary)["lastName"] as! String?),
                    let email = ((document.data()! as NSDictionary)["email"] as! String?) {
                    completion(["firstName": firstName, "lastName": lastName, "email": email])
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

    private func setUserDefaults(with email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
    }

}
