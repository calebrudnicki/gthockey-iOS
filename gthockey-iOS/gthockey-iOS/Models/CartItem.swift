//
//  CartItem.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/15/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class CartItem {

    private var id: Int
    private var name: String
    private var imageURL: URL
    private var price: Float
    private var attributes: [String : Any]

    // MARK: Init

    init(id: Int, name: String, imageURL: URL, price: Float, attributes: [String : Any]) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.price = price
        self.attributes = attributes
    }

    // MARK: Getters

    func getID() -> Int {
        return id
    }

    func getName() -> String {
        return name
    }

    func getImageURL() -> URL {
        return imageURL
    }

    func getPrice() -> Float {
        return price
    }

    func getPriceString() -> String {
        return "$" + String(format: "%.2f", price)
    }

    func getAttributes() -> [String: Any] {
        return attributes
    }

}
