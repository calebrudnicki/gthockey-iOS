//
//  DateExtension.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

extension Date {

    /// A formatted version of the `Date` in question that is regions specific.
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }

    /// A standard format of the `Date` in question that is not region specific.
    var standardFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy HH:mm a"
        return formatter.string(from: self)
    }

}
