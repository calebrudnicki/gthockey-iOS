//
//  Game.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 9/27/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

struct Game {
    var id: Int
    var dateTime: Date
    var opponentName: String
    var rinkName: String
    var venue: Venue
    var isReported: Bool
    var shortResult: String
    var gtScore: Int?
    var opponentScore: Int?
}
