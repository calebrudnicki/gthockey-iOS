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
    private var fcmToken: String
    private var lastLogin: String
    private var isAdmin: Bool
    private var appVersion: String
    private var uid: String

    // MARK: Init

    init(firstName: String, lastName: String, email: String, fcmToken: String,
         lastLogin: String, isAdmin: Bool, appVersion: String, uid: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.fcmToken = fcmToken
        self.lastLogin = lastLogin
        self.isAdmin = isAdmin
        self.appVersion = appVersion
        self.uid = uid
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

    func getFCMToken() -> String {
        return fcmToken
    }

    func getLastLogin() -> String {
        return lastLogin
    }

    func getIsAdmin() -> Bool {
        return isAdmin
    }

    func getAppVersion() -> String {
        return appVersion
    }

    func getUID() -> String {
        return uid
    }

}
