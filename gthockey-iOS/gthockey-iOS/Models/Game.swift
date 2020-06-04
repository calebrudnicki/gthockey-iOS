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
    var timestamp: Date
    var opponent: Team
    var venue: Venue
    var rink: Rink
    var season: Season
    var gtScore: Int?
    var opponentScore: Int?
    var shortResult: GameResult
}
