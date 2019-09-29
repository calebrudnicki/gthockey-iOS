//
//  Game.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 9/27/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class Game {
    private var id: Int
    private var dateTime: String
    private var opponentName: String
    private var rinkName: String
    private var venue: String
    private var isReported: Bool
    private var shortResult: String
    private var gtScore: Int
    private var opponentScore: Int
    
    init(id: Int, dateTime: String, opponentName: String, rinkName: String, venue: String, isReported: Bool, shortResult: String, gtScore:Int, opponentScore: Int) {
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
    
    func get_id() -> Int{
        return id
    }
    
    func get_date() -> String{
        return dateTime
    }
    
    func get_opponent() -> String{
        return opponentName
    }
    
    func get_rink() -> String{
        return rinkName
    }
    
    func get_venue() -> String{
        return venue
    }
    
    func get_reported() -> Bool{
        return isReported
    }
    
    func get_gtscore() -> Int{
        return gtScore
    }
    
    func get_opponentscore() -> Int{
        return opponentScore
    }
    
    
    
}

