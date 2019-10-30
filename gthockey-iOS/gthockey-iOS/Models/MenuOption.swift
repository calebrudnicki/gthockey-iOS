//
//  MenuOption.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/22/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

enum MenuOption: Int, CustomStringConvertible, CaseIterable {

    case Home
    case Schedule
    case Roster
    case Instagram
    case Twitter
    case Facebook

    var description: String {
        switch self {
        case .Home: return "Home"
        case .Schedule: return "Schedule"
        case .Roster: return "Roster"
        case .Instagram: return "Instagram"
        case .Twitter: return "Twitter"
        case .Facebook: return "Facebook"
        }
    }

    var image: UIImage {
        switch self {
        case .Home: return UIImage(named: "HomeIcon")!
        case .Schedule: return UIImage(named: "ScheduleIcon")!
        case .Roster: return UIImage(named: "RosterIcon")!
        case .Instagram: return UIImage(named: "InstagramIcon")!
        case .Twitter: return UIImage(named: "TwitterIcon")!
        case .Facebook: return UIImage(named: "FacebookIcon")!
        }
    }

    func count() -> Int {
        return MenuOption.allCases.count
    }

}
