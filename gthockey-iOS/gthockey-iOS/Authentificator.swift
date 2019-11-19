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

    public func login(with email: String, _ password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                completion(false, error)
            } else {
                self.setUserDefaults(with: email, password: password)
                completion(true, nil)
            }
        }
    }

    public func signup(with firstName: String, _ lastName: String, _ email: String,
                       _ password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completion(false, error)
            } else {
                let db = Firestore.firestore()
                guard let user = result?.user else { return }
                db.collection("users").document(user.uid).setData(["firstName": firstName,
                                                                   "lastName": lastName,
                                                                   "email": email,
                                                                   "uid": result?.user.uid ?? email,
                                                                   "cart": []]) { (error) in
                    if error != nil {
                        completion(false, error)
                    }
                    self.setUserDefaults(with: email, password: password)
                }
                completion(true, nil)
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

    public func getUserFirstName() -> String {
//        if let user = Auth.auth().currentUser {
//            let db = Firestore.firestore()
//            db.collection("users").document(user.uid).getDocument { (document, error) in
//            if let document = document, document.exists,
//                let firstName = ((document.data()! as NSDictionary)["firstName"] as! String?) {
//                return firstName
//                }
//            } else {
//                print("Document does not exist")
//            }
//        }
        return "Caleb"
    }

    // MARK: Private Functions

    private func setUserDefaults(with email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
    }

}
