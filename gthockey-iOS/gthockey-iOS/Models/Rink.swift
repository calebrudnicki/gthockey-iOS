//
//  Rink.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/14/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class Rink {

    // MARK: Properties

    private var id: Int
    private var name: String
    private var mapsURL: URL

    // MARK: Init

    init(id: Int, name: String, mapsURL: URL) {
        self.id = id
        self.name = name
        self.mapsURL = mapsURL
    }

    // MARK: Getters

    func getID() -> Int {
        return id
    }

    func getName() -> String {
        return name
    }

    func getMapsURL() -> URL {
        return mapsURL
    }

}
