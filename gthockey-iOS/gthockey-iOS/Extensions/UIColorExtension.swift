//
//  UIColorExtension.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/22/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let techNavy = UIColor(red: 37/255, green: 47/255, blue: 86/255, alpha: 1.0)
    static let techGold = UIColor(red: 213/255, green: 193/255, blue: 104/255, alpha: 1.0)
    static let techCream = UIColor(red: 225/255, green: 212/255, blue: 159/255, alpha: 1.0)

    static let winGreen = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 1.0)
    static let lossRed = UIColor(red: 178/255, green: 34/255, blue: 34/255, alpha: 1.0)

    static let gthBackgroundColor = UIColor.init(named: "GTHBackgroundColor")
    static let gthNavigationControllerTintColor = UIColor.init(named: "GTHNavigationControllerTintColor")
    static let gthTabBarControllerTintColor = UIColor.init(named: "GTHTabBarControllerTintColor")
    
    static let newsCellDateColor = UIColor.init(named: "NewsCellDateColor")
    static let newsCellTitleColor = UIColor.init(named: "NewsCellTitleColor")
    
    static let newsDetailDateColor = UIColor.init(named: "NewsDetailDateColor")
    static let newsDetailTitleColor = UIColor.init(named: "NewsDetailTitleColor")
    static let newsDetailContentColor = UIColor.init(named: "NewsDetailContentColor")
    
    static let scheduleCellTeamInfoColor = UIColor.init(named: "ScheduleCellTeamInfoColor")
    static let scheduleCellGameInfoColor = UIColor.init(named: "ScheduleCellGameInfoColor")
}
