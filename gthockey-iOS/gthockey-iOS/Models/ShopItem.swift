//
//  ShopItem.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/31/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class ShopItem {

    // MARK: Properties

    private var id: Int
    private var name: String
//    private var mapsURL: URL

    // MARK: Init

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    // MARK: Getters

    func getID() -> Int {
        return id
    }

    func getName() -> String {
        return name
    }
//
//    func getMapsURL() -> URL {
//        return mapsURL
//    }

}
