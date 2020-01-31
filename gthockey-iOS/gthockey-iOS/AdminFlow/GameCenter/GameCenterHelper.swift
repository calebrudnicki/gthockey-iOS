//
//  GameCenterHelper.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/30/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

class GameCenterHelper {

    // MARK: Properties
    
    var opponent: String?

    init() {}

    // MARK: Public Functions

    public func setOpponent(to opponent: String) {
        self.opponent = opponent
    }

}
