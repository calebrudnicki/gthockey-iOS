//
//  UserPropertyHelper.swift
//  
//
//  Created by Caleb Rudnicki on 2/15/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserPropertyHelper {

    init() {}

    // MARK: Public Functions

    /**
     Overrides a particular set of user properties in the database for one user.

     - Parameter dict: A dictionary representation of the user property or properties to override and the corresponding
     values to override them with (i.e. using `dict = ["firstName": "George"]` will make the selected user's `firstName`
     = "George".
     - Parameter uid: The unique identifier to represent the targeted user.

     - Completion: A block to execute once the user property or properties have been overriden
     */
    public func overrideForOneUser(with dict: [String: Any], for uid: String, completion: @escaping () -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { (document, error) in
            guard let document = document, document.exists else { return }

            for (key, val) in dict {
                document.reference.setData([key: val], merge: true)
            }
            completion()
        }
    }

    /**
     Overrides a particular set of user properties in the database for all users.

     - Parameter dict: A dictionary representation of the user property or properties to override and the corresponding
     values to override them with (i.e. using `dict = ["firstName": "George"]` will make all user's `firstName`
     = "George".

     - Completion: A block to execute once the user property or properties have been overriden
     */
    public func overrideForAllUsers(with dict: [String: Any], completion: @escaping () -> Void) {
        Firestore.firestore().collection("users").getDocuments { (document, error) in
            guard let documents = document?.documents else { return }

            for document in documents {
                for (key, val) in dict {
                    document.reference.setData([key: val], merge: true)
                }
            }
            completion()
        }
    }

}
