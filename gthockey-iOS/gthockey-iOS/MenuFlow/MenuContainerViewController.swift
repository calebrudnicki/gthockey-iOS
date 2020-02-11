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
    private let shopCollectionViewController: ShopCollectionViewController = {
        let shopLayout = UICollectionViewFlowLayout()
        shopLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 12.0, right: 0.0)
        let shopCollectionViewController = ShopCollectionViewController(collectionViewLayout: shopLayout)
        return shopCollectionViewController
    }()
    private let settingsTableViewController = SettingsTableViewController()
    private let allUsersTableViewController = AllUsersTableViewController()
    private let adminUsersTableViewController = AdminUsersTableViewController()
    private let notificationCenterViewController = NotificationCenterViewController()

    private var homeNavigationController: UINavigationController?
    private var scheduleNavigationController: UINavigationController?
    private var rosterNavigationController: UINavigationController?
    private var shopNavigationController: UINavigationController?
    private var settingsNavigationController: UINavigationController?
    private var allUsersNavigationController: UINavigationController?
    private var adminUsersNavigationController: UINavigationController?
    private var notificationCenterNavigationController: UINavigationController?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
        configureGestures()
    }

    func configureGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))

        leftSwipe.direction = .left
        rightSwipe.direction = .right

        currentNavigationController.view.addGestureRecognizer(leftSwipe)
        currentNavigationController.view.addGestureRecognizer(rightSwipe)
    }

    // MARK: Config

    private func configureHomeController() {
        homeNavigationController = UINavigationController(rootViewController: homeCollectionViewController)
        scheduleNavigationController = UINavigationController(rootViewController: scheduleTableViewController)
        rosterNavigationController = UINavigationController(rootViewController: rosterCollectionViewController)
        shopNavigationController = UINavigationController(rootViewController: shopCollectionViewController)
        settingsNavigationController = UINavigationController(rootViewController: settingsTableViewController)
        allUsersNavigationController = UINavigationController(rootViewController: allUsersTableViewController)
        adminUsersNavigationController = UINavigationController(rootViewController: adminUsersTableViewController)
        notificationCenterNavigationController = UINavigationController(rootViewController: notificationCenterViewController)

        homeCollectionViewController.delegate = self
        scheduleTableViewController.delegate = self
        rosterCollectionViewController.delegate = self
        shopCollectionViewController.delegate = self
        settingsTableViewController.delegate = self
        allUsersTableViewController.delegate = self
        adminUsersTableViewController.delegate = self
        notificationCenterViewController.delegate = self

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

    private func animatePanel(shouldExpand: Bool, mainMenuOption: MainMenuOption?) {
        if shouldExpand {
            //Animation to show menu
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.currentNavigationController.view.frame.origin.x = self.currentNavigationController.view.frame.width - 80
            }) { _ in
                self.currentNavigationController.topViewController?.view.isUserInteractionEnabled = false
            }
        } else {
            //Animation to hide menu
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.currentNavigationController.view.frame.origin.x = 0
            }) { _ in
                self.currentNavigationController.topViewController?.view.isUserInteractionEnabled = true

                guard let mainMenuOption = mainMenuOption,
                          mainMenuOption.description != self.currentNavigationController.children[0].navigationItem.title!
                else { return }

                self.didSelectMainMenuOption(mainMenuOption: mainMenuOption)
            }
        }
    }

    private func animatePanel(shouldExpand: Bool, adminMenuOption: AdminMenuOption?) {
        if shouldExpand {
            //Animation to show menu
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.currentNavigationController.view.frame.origin.x = self.currentNavigationController.view.frame.width - 80
            }) { _ in
                self.currentNavigationController.topViewController?.view.isUserInteractionEnabled = false
            }
        } else {
            //Animation to hide menu
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.currentNavigationController.view.frame.origin.x = 0
            }) { _ in
                self.currentNavigationController.topViewController?.view.isUserInteractionEnabled = true

                guard let adminMenuOption = adminMenuOption,
                          adminMenuOption.description != self.currentNavigationController.children[0].navigationItem.title!
                else { return }

                self.didSelectAdminMenuOption(adminMenuOption: adminMenuOption)
            }
        }
    }

    private func didSelectMainMenuOption(mainMenuOption: MainMenuOption) {
        currentNavigationController.view.removeFromSuperview()
        currentNavigationController.removeFromParent()

        switch mainMenuOption {
        case .Home:
            currentNavigationController = homeNavigationController
        case .Schedule:
            currentNavigationController = scheduleNavigationController
        case .Roster:
            currentNavigationController = rosterNavigationController
        case .Contact:
            let email = "georgiatechhockey@gmail.com"
            if let url = URL(string: "mailto:\(email)") {
              if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
              } else {
                UIApplication.shared.openURL(url)
              }
            }
        case .Shop:
            currentNavigationController = shopNavigationController
        case .Settings:
            currentNavigationController = settingsNavigationController
        }
        configureGestures()
        view.addSubview(currentNavigationController.view)
        addChild(currentNavigationController)
        currentNavigationController.didMove(toParent: self)
    }

    private func didSelectAdminMenuOption(adminMenuOption: AdminMenuOption) {
        currentNavigationController.view.removeFromSuperview()
        currentNavigationController.removeFromParent()

        switch adminMenuOption {
        case .AllUsers:
            currentNavigationController = allUsersNavigationController
        case .AdminUsers:
            currentNavigationController = adminUsersNavigationController
        case .SendNotification:
            currentNavigationController = notificationCenterNavigationController
//            UIApplication.shared.open(NSURL(string: "https://console.firebase.google.com/u/0/project/gthockey-ios/notification/compose")! as URL)
        }
        configureGestures()
        view.addSubview(currentNavigationController.view)
        addChild(currentNavigationController)
        currentNavigationController.didMove(toParent: self)
    }

    // MARK: Action

    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .right && !isExpanded) || (sender.direction == .left && isExpanded) {
            handleMenuToggle(forMainMenuOption: nil)
        }
    }

}

extension MenuContainerViewController: HomeControllerDelegate {

    // MARK: HomeControllerDelegate

    func handleMenuToggle(forMainMenuOption mainMenuOption: MainMenuOption?) {
        if !isExpanded {
            configureMenuController()
        }

        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, mainMenuOption: mainMenuOption)
    }

    func handleMenuToggle(forAdminMenuOption adminMenuOption: AdminMenuOption?) {
        if !isExpanded {
            configureMenuController()
        }

        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, adminMenuOption: adminMenuOption)
    }

}
