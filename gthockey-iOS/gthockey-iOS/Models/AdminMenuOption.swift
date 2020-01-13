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

    case AdminUsers

    var description: String {
        switch self {
        case .AdminUsers: return "Admin Users"
        }
    }

    var image: UIImage {
        switch self {
        case .AdminUsers:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "calendar")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage(named: "ScheduleIcon")!
        }
    }

    func count() -> Int {
        return AdminMenuOption.allCases.count
    }

}
