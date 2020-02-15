//
//  AppVersionHelper.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/15/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

class AppVersionHelper {

    init() {}

    // MARK: Public Functions

    /**
     Indicates whether the given version matches with the current app version in use.

     - Parameter version: A string representation of the version you wish to check.

     - Returns: A boolean indication of a match in versions.
     */
    public func isUpToDate(with version: String) -> Bool {
        return self.getCurrentVersion() == version
    }

    /**
    Finds and returns the current app version.

    - Returns: A string value holding the current version in use.
    */
    public func getCurrentVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "No Version Number"
    }

}
