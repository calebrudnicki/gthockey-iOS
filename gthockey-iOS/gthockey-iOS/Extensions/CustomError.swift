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

    public var errorDescription: String? {
        switch self {
        case .emailVerification:
            return NSLocalizedString("The email for this account is not yet verified. Be sure to check your email before logging in.",
                                     comment: "This error is thrown when a user has signed up for an account, but has not yet verified their email address.")
        }
    }
}
