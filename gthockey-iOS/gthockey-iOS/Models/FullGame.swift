//
//  FullGame.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 11/19/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
class FullGame {

    // MARK: Properties

    private var id: Int
    private var dateTime: Date
    private var opponent: Team
    private var rink: Rink
    private var venue: String
    private var shortResult: String
    private var gtScore: Int
    private var opponentScore: Int

    // MARK: Init

    init(id: Int, dateTime: Date, opponent: Team, rink: Rink, venue: String, shortResult: String, gtScore:Int, opponentScore: Int) {
        self.id = id
        self.dateTime = dateTime
        self.opponent = opponent
        self.rink = rink
        self.venue = venue
        self.shortResult = shortResult
        self.gtScore = gtScore
        self.opponentScore = opponentScore
    }

    // MARK: Getters

    func getID() -> Int {
        return id
    }

    func getDateTime() -> Date {
        return dateTime
    }

    func getOpponent() -> Team {
        return opponent
    }

    func getRink() -> Rink {
        return rink
    }

    func getVenue() -> String {
        return venue
    }

    func getShortResult() -> String {
        return shortResult
    }

    func getGTScore() -> Int{
        return gtScore
    }

    func getOpponentScore() -> Int {
        return opponentScore
    }

}
