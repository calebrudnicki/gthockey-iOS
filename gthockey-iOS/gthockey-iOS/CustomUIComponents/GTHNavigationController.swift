//
//  GTHNavigationController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GTHNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        delegate = self

        navigationBar.prefersLargeTitles = true

        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.GTHNavigationControllerTextColor,
            .font: UIFont.DINCondensed.bold.font(size: 48.0)
        ]
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.GTHNavigationControllerTextColor,
            .font: UIFont.DINCondensed.bold.font(size: 24.0)
        ]

    }

}

extension GTHNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController as? HomeCollectionViewController != nil {
            navigationBar.topItem?.title = "News"
        } else if viewController as? ScheduleTableViewController != nil {
            navigationBar.topItem?.title = "Schedule"
        } else if viewController as? RosterDetailViewController != nil {
            navigationBar.topItem?.title = "Roster"
        } else if viewController as? ShopCollectionViewController != nil {
            navigationBar.topItem?.title = "Shop"
        } else {
            navigationBar.topItem?.title = "Settings"
        }
    }

}
