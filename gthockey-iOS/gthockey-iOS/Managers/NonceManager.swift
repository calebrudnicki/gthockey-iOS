//
//  NonceManager.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/11/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import CryptoKit

class NonceManager {

    // MARK: Init

    init() {}

    // MARK: Public Functions

    /**
     Generates a cryptographically secure nonce.

     - Parameter length: An `Int` of the number of bits desired.
     */
    public func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }

    /**
     Finds the SHA256 hash of the nonce.

     - Parameter input: A `String` of nonce that is to be hashed.
     */
    public func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }

}
