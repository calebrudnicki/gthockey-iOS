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
    
    init(id_: Int, dt: String, on: String, rn: String, v: String, ir: Bool, sr: String, gs:Int, os: Int) {
        id = id_
        dateTime = dt
        opponentName = on
        rinkName = rn
        venue = v
        isReported = ir
        shortResult = sr
        gtScore = gs
        opponentScore = os
       
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

