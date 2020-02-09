//
//  Season.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/7/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

class Season {

    // MARK: Properties

    private var id: Int
    private var name: String
    private var year: Int

    // MARK: Init

    init(id: Int, name: String, year: Int) {
        self.id = id
        self.name = name
        self.year = year
    }

    // MARK: Getters

    func getID() -> Int {
        return id
    }

    func getName() -> String {
        return name
    }

    func getYear() -> Int {
        return year
    }

}
