//
//  Game.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 9/27/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class Game {

    // MARK: Properties

    private var id: Int
    private var dateTime: Date
    private var opponentName: String
    private var rinkName: String
    private var venue: String
    private var isReported: Bool
    private var shortResult: String
    private var gtScore: Int
    private var opponentScore: Int

    // MARK: Init

    init(id: Int, dateTime: Date, opponentName: String, rinkName: String, venue: String,
         isReported: Bool, shortResult: String, gtScore:Int, opponentScore: Int) {
        self.id = id
        self.dateTime = dateTime
        self.opponentName = opponentName
        self.rinkName = rinkName
        self.venue = venue
        self.isReported = isReported
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

    func getOpponentName() -> String {
        return opponentName
    }

    func getRinkName() -> String {
        return rinkName
    }

    func getVenue() -> String {
        return venue
    }

    func getIsReported() -> Bool {
        return isReported
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
