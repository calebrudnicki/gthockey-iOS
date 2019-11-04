//
//  Apparel.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/31/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class Apparel {

    // MARK: Properties

    private var id: Int
    private var name: String
    private var price: Float
    private var description: String
    private var imageURL: URL

    // MARK: Init

    init(id: Int, name: String, price: Float, description: String, imageURL: URL) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.imageURL = imageURL
    }

    // MARK: Getters
    
    func getID() -> Int {
        return id
    }

    func getName() -> String {
        return name
    }

    func getPrice() -> Float {
        return price
    }

    func getDescription() -> String {
        return description
    }

    func getImageURL() -> URL {
        return imageURL
    }

}
