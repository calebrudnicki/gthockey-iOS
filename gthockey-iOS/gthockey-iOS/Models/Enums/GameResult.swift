//
//  GameResult.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 6/4/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

enum GameResult {

    case Win
    case Loss
    case Tie
    case OvertimeLoss
    case Unknown

    var description: String {
        switch self {
        case .Win: return "Win"
        case .Loss: return "Loss"
        case .Tie: return "T"
        case .OvertimeLoss: return "OT Loss"
        case .Unknown: return "Unknown"
        }
    }

}
