//
//  AppUser.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/13/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

class AppUser {

    // MARK: Properties

    private var firstName: String
    private var lastName: String
    private var email: String

    // MARK: Init

    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }

    // MARK: Getters

    func getFirstName() -> String {
        return firstName
    }

    func getLastName() -> String {
        return lastName
    }

    func getEmail() -> String {
        return email
    }

}
