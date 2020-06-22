//
//  Game.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 9/27/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

struct Game {
    let id: Int
    let timestamp: Date
    let opponent: Team
    let venue: Venue
    let rink: Rink
    let season: Season
    let gtScore: Int?
    let opponentScore: Int?
    let shortResult: GameResult
}
