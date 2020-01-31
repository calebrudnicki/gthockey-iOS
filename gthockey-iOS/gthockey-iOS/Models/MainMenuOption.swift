//
//  MainMenuOption.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/12/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

enum MainMenuOption: Int, CustomStringConvertible, CaseIterable {

    case Home
    case Schedule
    case Roster
    case Contact
    case Shop
    case Settings

    var description: String {
        switch self {
        case .Home: return "Home"
        case .Schedule: return "Schedule"
        case .Roster: return "Roster"
        case .Contact: return "Contact"
        case .Shop: return "Shop"
        case .Settings: return "Settings"
        }
    }

    var image: UIImage {
        switch self {
        case .Home:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "house.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage()
        case .Schedule:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "calendar")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage()
        case .Roster:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "person.3.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage()
        case .Contact:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "envelope.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage()
        case .Shop:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "bag.fill")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage()
        case .Settings:
            if #available(iOS 13.0, *) {
                return (UIImage(systemName: "gear")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.white))!
            }
            return UIImage()
        }
    }

    func count() -> Int {
        return MainMenuOption.allCases.count
    }

}
