//
//  GTHTabBarController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GTHTabBarController: UITabBarController {

    // MARK: Properties

    private let indicatorPlatform = UIView()

    private let homeCollectionViewController: HomeCollectionViewController = {
        let homeLayout = UICollectionViewFlowLayout()
        homeLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 12.0, right: 0.0)
        let homeCollectionViewController = HomeCollectionViewController(collectionViewLayout: homeLayout)
        return homeCollectionViewController
    }()

    private let scheduleTableViewController = ScheduleTableViewController()

    private let rosterCollectionViewController: RosterCollectionViewController = {
        let rosterLayout = UICollectionViewFlowLayout()
        rosterLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 12.0, right: 0.0)
        let rosterCollectionViewController = RosterCollectionViewController(collectionViewLayout: rosterLayout)
        return rosterCollectionViewController
    }()

    private let shopCollectionViewController: ShopCollectionViewController = {
        let shopLayout = UICollectionViewFlowLayout()
        shopLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 12.0, right: 0.0)
        let shopCollectionViewController = ShopCollectionViewController(collectionViewLayout: shopLayout)
        return shopCollectionViewController
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        let newsNavigationController = GTHNavigationController(rootViewController: homeCollectionViewController)
        newsNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)

        let scheduleNavigationController = GTHNavigationController(rootViewController: scheduleTableViewController)
        scheduleNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "calendar"), tag: 1)

        let rosterNavigationController = GTHNavigationController(rootViewController: rosterCollectionViewController)
        rosterNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.2"), tag: 2)

        let shopNavigatinController = GTHNavigationController(rootViewController: shopCollectionViewController)
        shopNavigatinController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "cart"), tag: 3)

        let moreNavigationController = GTHNavigationController(rootViewController: UIViewController())
        moreNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "line.horizontal.3"), tag: 4)

        setViewControllers([
            newsNavigationController,
            scheduleNavigationController,
            rosterNavigationController,
            shopNavigatinController,
            moreNavigationController
        ], animated: true)

        setupIndicatorPlatform()

        tabBar.barTintColor = UIColor.gthBackgroundColor
        tabBar.tintColor = UIColor.gthTabBarControllerTintColor
        tabBar.isTranslucent = false
    }

    // MARK: UITabBarDelegate

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = CGFloat(integerLiteral: tabBar.items!.firstIndex(of: item)!)
        let itemWidth = indicatorPlatform.frame.width
        let newCenterX = (itemWidth / 2.0) + (itemWidth * index)

        UIView.animate(withDuration: 0.3) {
            self.indicatorPlatform.center.x = newCenterX
        }
    }

    // MARK: Private Functions

    private func setupIndicatorPlatform() {
        let tabBarItemSize = CGSize(width: tabBar.frame.width / CGFloat(tabBar.items!.count), height: tabBar.frame.height)
        indicatorPlatform.backgroundColor = UIColor.gthTabBarControllerTintColor
        indicatorPlatform.frame = CGRect(x: 0.0, y: 0.0, width: tabBarItemSize.width, height: 2.0)
        indicatorPlatform.center.x = tabBar.frame.width / CGFloat(tabBar.items!.count) / 2.0
        tabBar.addSubview(indicatorPlatform)
    }

}
