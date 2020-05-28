//
//  GTHNavigationController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GTHNavigationController: UINavigationController {

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
    
        delegate = self

        navigationBar.prefersLargeTitles = true
        navigationBar.barTintColor = UIColor.gthBackgroundColor

        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.gthNavigationControllerTintColor as Any,
            .font: UIFont.DINCondensed.bold.font(size: 48.0)
        ]
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.gthNavigationControllerTintColor as Any,
            .font: UIFont.DINCondensed.bold.font(size: 24.0)
        ]
    }

}

extension GTHNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController as? NewsCollectionViewController != nil {
            navigationBar.topItem?.title = "News"
        } else if viewController as? ScheduleCollectionViewController != nil {
            navigationBar.topItem?.title = "Schedule"
        } else if viewController as? RosterCollectionViewController != nil {
            navigationBar.topItem?.title = "Roster"
        } else if viewController as? ShopCollectionViewController != nil {
            navigationBar.topItem?.title = "Shop"
        } else if viewController as? MoreTableViewController != nil {
            navigationBar.topItem?.title = "More"
        }
    }

}
