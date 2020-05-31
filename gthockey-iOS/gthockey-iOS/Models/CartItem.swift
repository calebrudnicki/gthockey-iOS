//
//  CartItem.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/15/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

struct CartItem: Equatable {
    
    var id: Int
    var name: String
    var imageURL: URL
    var price: Double
    var attributes: [String : Any]
    
    // MARK: Getters
    
    func getPrice() -> Double {
        return price * 100.0
    }

    func getPriceString() -> String {
        return "$" + String(format: "%.2f", price)
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
