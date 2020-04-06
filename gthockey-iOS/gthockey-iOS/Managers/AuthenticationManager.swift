//
//  AuthenticationManager.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseAnalytics

class AuthenticationManager {

    // MARK: Init

    init() {}

    // MARK: Public Functions

    /**
     Logs a user into the application.

     - Parameter email: A `String` representation of the user's email address.
     - Parameter password: A `String` representation of the user's password.
     - Parameter firstName: A `String` representation of the user's first name.
     - Parameter lastName: A `String` representation of the user's last name.
     - Parameter completion: A block to execute once the user's has been logged in.
     */
    public func login(with email: String, _ password: String, _ firstName: String?,
                      _ lastName: String?, completion: @escaping (Bool, Error?) -> Void) {
        AdminManager().saveAdminUsersOnLaunch(completion: { _ in
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if let error = error, user == nil {
                    completion(false, error)
                } else {
                    if let user = user?.user, user.isEmailVerified {


                        self.getUserPropertiesForLogin(completion: { _ in
                            UserPropertyManager().overrideForOneUser(with: ["lastLogin": Date().standardFormatted],
                                                                     for: user.uid, completion: {
                                let pushManager = PushNotificationManager(userID: user.uid)
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

    /**
    Creates a brand new user.

    - Parameter firstName: A `String` representation of the new user's first name.
    - Parameter lastName: A `String` representation of the new user's last name.
    - Parameter email: A `String` representation of the new user's email address.
    - Parameter password: A `String` representation of the new user's password.
    - Parameter completion: A block to execute once the user's has been created.
    */
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
                                                                   "isAdmin": AdminManager().isAdminUser(email) ?
                                                                                                        true :
                                                                                                        false,
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

    /**
     Send the password reset email to the specified user.

     - Parameter email: A `String` representation of the email in question.
     - Parameter completion: A block to execute once the password reset email has been sent.
     */
    public func resetPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { error in
            if error != nil {
                completion(error)
            }
            completion(nil)
        })
    }

    /**
     Signs the current user out of the application.

     - Parameter completion: A block to execute once the user's is logged out.
     */
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

    // MARK: Private Functions

    private func getUserPropertiesForLogin(completion: @escaping ([String : Any]) -> Void) {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                guard let document = document,
                            document.exists
                else { return }

                let versionNumber = ((document.data()! as NSDictionary)["versionNumber"] as? String ??
                                                                                    "No Version Number")

                if !AppVersionManager().isUpToDate(with: versionNumber) {
                    //Update for newest version
                    var dict: [String : Any] = [:]

                    //v1.4
                    let appIcon = document["appIcon"] as? String ?? "Buzz"
                    dict["appIcon"] = appIcon
                    //v1.5
                    let versionNumber = AppVersionManager().getCurrentVersion()
                    dict["versionNumber"] = versionNumber
                    let fcmToken = document["fcmToken"] as? String ?? "No FCM Token"
                    dict["fcmToken"] = fcmToken

                    UserPropertyManager().overrideForOneUser(with: dict, for: user.uid, completion: {
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
                    UserPropertyManager().getAllPropertiesForCurrentUser(completion: { userProperties in
                        completion(userProperties)
                    })
                }
            }
        }
    }

    private func setUserDefaults(with email: String, password: String, isAdmin: Bool) {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
    }

}
