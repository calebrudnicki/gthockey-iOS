//
//  MenuOption.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/22/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

enum MenuOption: Int, CustomStringConvertible {

    case Home
    case Schedule
    case Roster

    var description: String {
        switch self {
        case .Home: return "Home"
        case .Schedule: return "Schedule"
        case .Roster: return "Roster"
        }
    }

    var image: UIImage {
        switch self {
        case .Home: return UIImage(named: "HomeIcon")!
        case .Schedule: return UIImage(named: "ScheduleIcon")!
        case .Roster: return UIImage(named: "RosterIcon")!
        }
    }

}
