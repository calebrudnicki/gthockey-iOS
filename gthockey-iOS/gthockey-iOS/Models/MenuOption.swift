//
//  MenuOption.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/22/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

enum MenuOption: Int, CustomStringConvertible, CaseIterable {

    case Home
    case Schedule
    case Roster
    case Shop
    case Settings

    var description: String {
        switch self {
        case .Home: return "Home"
        case .Schedule: return "Schedule"
        case .Roster: return "Roster"
        case .Shop: return "Shop"
        case .Settings: return "Settings"
        }
    }

    var image: UIImage {
        switch self {
        case .Home:
            if #available(iOS 13.0, *){
                return (UIImage(systemName: "house.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage(named: "HomeIcon")!
        case .Schedule:
            if #available(iOS 13.0, *){
                return (UIImage(systemName: "calendar")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage(named: "ScheduleIcon")!
        case .Roster:
            if #available(iOS 13.0, *){
                return (UIImage(systemName: "person.3.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage(named: "RosterIcon")!
        case .Shop:
            if #available(iOS 13.0, *){
                return (UIImage(systemName: "bag.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage(named: "ShopIcon")!
        case .Settings:
            if #available(iOS 13.0, *){
                return (UIImage(systemName: "gear")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage(named: "ShopIcon")!
        }
    }

    func count() -> Int {
        return MenuOption.allCases.count
    }

}
