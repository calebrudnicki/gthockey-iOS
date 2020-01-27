//
//  AppIcon.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/22/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

enum AppIcon: CaseIterable {

    case Buzz
    case HeritageT
    case RamblinReck

    var description: String {
        switch self {
        case .Buzz: return "Buzz"
        case .HeritageT: return "HeritageT"
        case .RamblinReck: return "RamblinReck"
        }
    }

    func count() -> Int {
        return AppIcon.allCases.count
    }

}
