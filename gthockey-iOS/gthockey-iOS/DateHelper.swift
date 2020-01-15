//
//  DateHelper.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/14/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation

class DateHelper {

    init() {}

    // MARK: Public Functions

    public func formatDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy"
        return formatter.string(from: date)
    }

    public func formatDate(from dateString: String, withTime: Bool) -> Date {
        let formatter = DateFormatter()
        if withTime {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        } else {
            formatter.dateFormat = "yyyy-MM-dd"
        }
        return formatter.date(from: dateString)!
    }

    public func formatTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }

}
