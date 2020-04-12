//
//  AppIconManager.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

class AppIconManager {

    // MARK: Init

    init() {}

    // MARK: Public Functions

    /**
     Sets the default app icon saved locally as the main Buzz icon if there is not already a value stored.
     */
    public func setOnLogin() {
        if let _ = UserDefaults.standard.value(forKey: "appIcon") as? String { return }
        UserDefaults.standard.set(AppIcon.Buzz.description, forKey: "appIcon")
    }

    /**
     Indicates whether the icon in question is the icon that is currently set as the user's default icon.

     - Parameter icon: A `AppIcon` object of the icon to be tested.
     - Returns: A `Bool` indication of if the provided icon is the same icon that the user has as their current default.
     */
    public func isDefaultIcon(_ icon: AppIcon) -> Bool {
        guard let iconDescription = UserDefaults.standard.value(forKey: "appIcon") as? String else { return false }
        return icon.description == iconDescription
    }

    /**
     Removes the local default for the user's selected icon to be used on sign out.
     */
    public func clear() {
        UserDefaults.standard.removeObject(forKey: "appIcon")
    }

    /**
     Switches the app icon.

     - Parameter icon: A `AppIcon` representation of the new icon that the user has selected as the default.
     - Parameter completion: A block to execute once the icon has been assigned.
     */
    public func switchAppIcon(to icon: AppIcon, completion: @escaping (Error?) -> Void) {
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }

        UIApplication.shared.setAlternateIconName(icon.description, completionHandler: { (error) in
            if let error = error {
                completion(error)
            } else {
                //Successfully changed app icon
                UserDefaults.standard.set(icon.description, forKey: "appIcon")
                completion(nil)
            }
        })
    }

}
