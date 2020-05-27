//
//  Position.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

enum Position {

    case Forward
    case Defense
    case Goalie
    case Manager

    var description: String {
        switch self {
        case .Forward: return "Forward"
        case .Defense: return "Defense"
        case .Goalie: return "Goalie"
        case .Manager: return "Manager"
        }
    }
    
    var shortDescription: String {
        switch self {
        case .Forward: return "F"
        case .Defense: return "D"
        case .Goalie: return "G"
        case .Manager: return "M"
        }
    }

}
