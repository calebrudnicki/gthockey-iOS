//
//  CustomError.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

public enum CustomError: Error, LocalizedError {

    case emailVerification
    case failedSignIn
    case unverifiedUser

    public var errorDescription: String? {
        switch self {
        case .emailVerification:
            return NSLocalizedString("The email for this account is not yet verified. Be sure to check your email before logging in.",
                                     comment: "This error is thrown when a user has signed up for an account, but has not yet verified their email address.")
        case .failedSignIn:
            return NSLocalizedString("Something went wrong while trying to sign in.",
                                     comment: "This error is thrown the sign in process through an email verification could not be completed.")

        case .unverifiedUser:
            return NSLocalizedString("The current user that you are trying to log in as is not yet verified through email. Check your email to complete the verification process.",
                                     comment: "This error is thrown during sign in when an unverified user attempts to log in. To be verified through their email address.")
        }
    }
    
}
