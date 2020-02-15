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
import FirebaseAnalytics

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


                        self.getUserPropertiesForLogin(completion: { _ in
                            AdminHelper().overrideForOneUser(with: ["lastLogin": DateHelper().getTimestamp()], for: user.uid, completion: {
                                let pushManager = PushNotificationHelper(userID: user.uid)
                                pushManager.registerForPushNotifications()

                                self.setUserDefaults(with: email, password: password, isAdmin: true)
                                completion(true, nil)
                            })
                        })

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
                                                                   "appIcon": "Buzz",
                                                                   "fcmToken": "No FCM Token",
                                                                   "versionNumber": "No Version Number",
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
            UserDefaults.standard.removeObject(forKey: "isRegisteredForNotifications")
            UIApplication.shared.unregisterForRemoteNotifications()
            completion(true, nil)
        } catch let error as NSError {
            completion(false, error)
        }
    }

    private func getUserPropertiesForLogin(completion: @escaping ([String : Any]) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                guard let document = document,
                            document.exists
                else { return }

                let versionNumber = ((document.data()! as NSDictionary)["versionNumber"] as? String ?? "No Version Number")

                if self.isFirstVersionUse(userVersion: versionNumber) {
                    //Update for newest version
                    var dict: [String : Any] = [:]

                    //v1.4
                    let appIcon = document["appIcon"] as? String ?? "Buzz"
                    dict["appIcon"] = appIcon
                    //v1.5
                    let versionNumber = self.getVersionNumber()
                    dict["versionNumber"] = versionNumber
                    let fcmToken = document["fcmToken"] as? String ?? "No FCM Token"
                    dict["fcmToken"] = fcmToken

                    AdminHelper().overrideForOneUser(with: dict, for: user.uid, completion: {
                        print("updated user")
                        completion(["firstName": document["firstName"] as? String ?? "",
                                    "lastName": document["lastName"] as? String ?? "",
                                    "email": document["email"] as? String ?? "",
                                    "appIcon": appIcon,
                                    "fcmToken": fcmToken,
                                    "versionNumber": versionNumber,
                                    "cart": document["cart"] as? String ?? []
                        ])
                    })
                } else {
                    completion(["firstName": document["firstName"] as? String ?? "",
                                "lastName": document["lastName"] as? String ?? "",
                                "email": document["email"] as? String ?? "",
                                "appIcon": document["appIcon"] as? String ?? "",
                                "fcmToken": document["fcmToken"] as? String ?? "",
                                "versionNumber": versionNumber,
                                "cart": document["cart"] as? String ?? []
                    ])
                }
            }
        }
    }

    public func getUserProperties1(completion: @escaping ([String : Any]) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                guard let document = document,
                    document.exists
                    else { return }

                completion(["firstName": document["firstName"] as? String ?? "",
                            "lastName": document["lastName"] as? String ?? "",
                            "email": document["email"] as? String ?? "",
                            "appIcon": document["appIcon"] as? String ?? "",
                            "fcmToken": document["fcmToken"] as? String ?? "",
                            "versionNumber": document["versionNumber"] as? String ?? "",
                            "cart": document["cart"] as? String ?? []
                ])
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

    public func updateUserProperties(with appIcon: String, completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).updateData(["appIcon": appIcon])
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

    private func getVersionNumber() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "No Version Number"
    }

    private func isFirstVersionUse(userVersion: String) -> Bool {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version != userVersion
        }
        return false
    }

}
