//
//  CartItem.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/15/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class CartItem: Equatable {

    // MARK: Properties

    private var id: Int
    private var name: String
    private var imageURL: URL
    private var price: Double
    private var attributes: [String : Any]

    // MARK: Init

    init(id: Int, name: String, imageURL: URL, price: Double, attributes: [String : Any]) {
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

    func getPrice() -> Double {
        return price * 100.0
    }

    func getPriceString() -> String {
        return "$" + String(format: "%.2f", price)
    }

    func getAttributes() -> [String: Any] {
        return attributes
    }

    // MARK: Equatable

    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        if lhs.id == rhs.id {
            for (rhsKey, rhsVal) in rhs.attributes {
                guard let lhsVal = lhs.attributes[rhsKey] else {
                    return false
                }
                if (lhsVal as! String) != (rhsVal as? String) {
                    return false
                }
            }
            return true
        }
        return false
    }

}
