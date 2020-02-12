//
//  AppIconHelper.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/12/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

class AppIconHelper {

    init() {}

    // MARK: Public Functions

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
