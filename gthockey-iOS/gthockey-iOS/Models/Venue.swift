//
//  Venue.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/6/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

enum Venue {

    case Home
    case Away
    case Tournament

    var description: String {
        switch self {
        case .Home: return "Home"
        case .Away: return "Away"
        case .Tournament: return "Tournament"
        }
    }

}
