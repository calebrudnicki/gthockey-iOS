//
//  MenuContainerViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/20/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MenuContainerViewController: UIViewController {

    // MARK: Properties

    private var menuTableViewController: MenuTableViewController!
    private var currentNavigationController: UINavigationController!
    private var isExpanded = false
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
    private var homeNavigationController: UINavigationController?
    private var scheduleNavigationController: UINavigationController?
    private var rosterNavigationController: UINavigationController?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }

    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }

    // MARK: Config
    
    private func configureHomeController() {
        homeNavigationController = UINavigationController(rootViewController: homeCollectionViewController)
        scheduleNavigationController = UINavigationController(rootViewController: scheduleTableViewController)
        rosterNavigationController = UINavigationController(rootViewController: rosterCollectionViewController)

        homeCollectionViewController.delegate = self
        scheduleTableViewController.delegate = self
        rosterCollectionViewController.delegate = self

        //Set default screen to be Home
        currentNavigationController = homeNavigationController

        view.backgroundColor = .techNavy

        view.addSubview(currentNavigationController.view)
        addChild(currentNavigationController)
        currentNavigationController.didMove(toParent: self)
    }

    private func configureMenuController() {
        if menuTableViewController == nil {
            menuTableViewController = MenuTableViewController()
            menuTableViewController.delegate = self
            view.insertSubview(menuTableViewController.view, at: 0)
            addChild(menuTableViewController)
            menuTableViewController.didMove(toParent: self)
        }
    }

    // MARK: Menu Control Functions

    private func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        if shouldExpand {
            //Animation to show menu
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.currentNavigationController.view.frame.origin.x = self.currentNavigationController.view.frame.width - 80
            }) { (_) in
                self.currentNavigationController.topViewController?.view.isUserInteractionEnabled = false
            }
        } else {
            //Animation to hide menu
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.currentNavigationController.view.frame.origin.x = 0
            }) { (_) in
                self.currentNavigationController.topViewController?.view.isUserInteractionEnabled = true
                
                guard let menuOption = menuOption,
                          menuOption.description != self.currentNavigationController.children[0].navigationItem.title!
                else { return }

                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
    }

    private func didSelectMenuOption(menuOption: MenuOption) {
        currentNavigationController.view.removeFromSuperview()
        currentNavigationController.removeFromParent()

        switch menuOption {
        case .Home:
            currentNavigationController = homeNavigationController
        case .Schedule:
            currentNavigationController = scheduleNavigationController
        case .Roster:
            currentNavigationController = rosterNavigationController
//        case .Instagram:
//            let appURL = NSURL(string: "instagram://user?username=gthockey")!
//            let webURL = NSURL(string: "https://instagram.com/gthockey")!
//
//            let application = UIApplication.shared
//
//            if application.canOpenURL(appURL as URL) {
//                 application.open(appURL as URL)
//            } else {
//                 application.open(webURL as URL)
//            }
//        case .Twitter:
//            let appURL = NSURL(string: "twitter://user?screen_name=GT_Hockey")!
//            let webURL = NSURL(string: "https://twitter.com/GT_Hockey")!
//
//            let application = UIApplication.shared
//
//            if application.canOpenURL(appURL as URL) {
//                 application.open(appURL as URL)
//            } else {
//                 application.open(webURL as URL)
//            }
//        case .Facebook:
//            let appURL = NSURL(string: "fb://profile/85852244494")!
//            let webURL = NSURL(string: "https://facebook.com/GeorgiaTechHockey")!
//
//            let application = UIApplication.shared
//
//            if application.canOpenURL(appURL as URL) {
//                 application.open(appURL as URL)
//            } else {
//                 application.open(webURL as URL)
//            }
        }

        view.addSubview(currentNavigationController.view)
        addChild(currentNavigationController)
        currentNavigationController.didMove(toParent: self)
    }

}

extension MenuContainerViewController: HomeControllerDelegate {

    // MARK: HomeControllerDelegate

    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }

        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }

}
