//
//  AuthenticationManager.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import FirebaseAuth

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
    
    public func signInAnonymously(_ completion: @escaping (Bool) -> Void) {
        Auth.auth().signInAnonymously() { authResult, error in
            guard let _ = authResult?.user else {
                completion(false)
                return
            }
            
//            PushNotificationManager().registerForPushNotifications()
            completion(true)
        }
    }

}
