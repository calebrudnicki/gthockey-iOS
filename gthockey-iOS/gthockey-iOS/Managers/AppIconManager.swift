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
                print("App icon failed to change due to \(error.localizedDescription)")
            } else {
                completion(nil)
                print("App icon changed successfully")
            }
        })
    }

}
