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

class AuthenticationManager {

    // MARK: Init

    init() {}

    // MARK: Public Variables

    /// Returns a `Bool` value indicating whether there exists a current user stored in Firebase Auth
    public var isUserSignedIn: Bool {
        if let _ = Auth.auth().currentUser { return true }
        return false
    }

    /// Returns an optional `String` value of the current Firebase user's email address
    public var currentUserEmail: String? {
        if let user = Auth.auth().currentUser {
            return user.email
        }
        return nil
    }

    // MARK: Public Functions

    /**
     Creates an settings object that is to be used when sending an email link upon sign in.

     - Parameter email: A `String` of the email that will be used at sign in.

     - Returns: An `ActionCodeSettings` object holding the user's email.
     */
    public func contructActionCodeSettings(for email: String) -> ActionCodeSettings {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.url = URL(string: String(format: "https://gthockey-ios.firebaseapp.com/?email=%@", email))
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        return actionCodeSettings
    }

    /**
    Sends a sign in link via email to allow a user to sign into the application without a password.

    - Parameter email: A `String` of the email to which the link will be sent.
    - Parameter settings: An `ActionCodeSettings` object holding the pertinent information to complete a sign in via email.
    - Parameter completion: A block to execute once the email has been sent containing an optional `Error` object to
     indicate the sucess of the action.
    */
    public func sendSignInLink(to email: String, with settings: ActionCodeSettings, _ completion: @escaping (Error?) -> Void) {
        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: settings) { error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }

    /**
     Signs a user in using Firebase Authentication in the case where the user is coming from a passwordless email link.

     - Parameter email: A `String` of the email that will be used in the signing in process.
     - Parameter link: A `String` of the link that the user carried from their email into the application.
     - Parameter completion: A block to execute once the user has been signed in containing an optional `Error` object
     to indicate the sucess of the action.
     */
    public func signIn(withEmail email: String, _ link: String, _ completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, link: link, completion: { result, error in
            if let error = error {
                completion(error)
                return
            }

            if result != nil {
                if (Auth.auth().currentUser?.isEmailVerified)! {
                    AppIconManager().setOnLogin()
                    PushNotificationManager().registerForPushNotifications()
                    completion(nil)
                } else {
                    completion(CustomError.unverifiedUser)
                }
            }
        })
    }

    /**
    Signs a user in using Firebase Authentication in the case where the user is signing in with Apple.

    - Parameter tokenString: A `String` of the email that will be used in the signing in process.
    - Parameter nonce: A `String` of a randomly generated token used to make sure the token was granted appropriately.
    - Parameter completion: A block to execute once the user has been signed in containing an optional `Error` object
    to indicate the sucess of the action.
    */
    public func signIn(withToken tokenString: String, _ nonce: String, _ completion: @escaping (Error?) -> Void) {
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)

        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                completion(error)
                return
            }

            AppIconManager().setOnLogin()
            PushNotificationManager().registerForPushNotifications()
            completion(nil)
        }
    }

    /**
     Signs a user out using Firebase Authentication and clears all of the locally saved data.

     - Parameter completion: A block to execute once the user has been signed in containing an optional `Error` object
     to indicate the sucess of the action.
     */
    public func signOut(_ completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            AppIconManager().clear()
            PushNotificationManager().clear()
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }

}
