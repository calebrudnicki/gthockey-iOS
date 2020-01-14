//
//  AdminMenuOption.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/12/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

enum AdminMenuOption: Int, CustomStringConvertible, CaseIterable {

    case AllUsers
    case AdminUsers
    case SendNotification

    var description: String {
        switch self {
        case .AllUsers: return "All Users"
        case .AdminUsers: return "Admin Users"
        case .SendNotification: return "Send Notification"
        }
    }

    var image: UIImage {
        switch self {
        case .AllUsers:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "person.3.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.techNavy))!
            }
            return UIImage(named: "RosterIcon")!
        case .AdminUsers:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "person.2.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.techNavy))!
            }
            return UIImage(named: "RosterIcon")!
        case .SendNotification:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "paperplane.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage(named: "RosterIcon")!
        }
    }

    func count() -> Int {
        return AdminMenuOption.allCases.count
    }

}
