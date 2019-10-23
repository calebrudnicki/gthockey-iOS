//
//  MenuOption.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/22/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

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

}
