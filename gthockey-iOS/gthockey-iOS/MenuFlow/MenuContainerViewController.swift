//
//  MenuContainerViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/20/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MenuContainerViewController: UIViewController {

    var menuController: MenuViewController!
    var currentNavigationController: UINavigationController!
    var isExpanded = false

    let homeCollectionViewController: HomeCollectionViewController = {
        let homeLayout = UICollectionViewFlowLayout()
        homeLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 12.0, right: 0.0)
        let homeCollectionViewController = HomeCollectionViewController(collectionViewLayout: homeLayout)
        return homeCollectionViewController
    }()

    let scheduleTableViewController = ScheduleTableViewController()

    let rosterCollectionViewController: RosterCollectionViewController = {
        let rosterLayout = UICollectionViewFlowLayout()
        rosterLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 12.0, right: 0.0)
        let rosterCollectionViewController = RosterCollectionViewController(collectionViewLayout: rosterLayout)
        return rosterCollectionViewController
    }()

    var homeNavigationController: UINavigationController!
    var scheduleNavigationController: UINavigationController!
    var rosterNavigationController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }

    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    func configureHomeController() {
        homeNavigationController = UINavigationController(rootViewController: homeCollectionViewController)
        scheduleNavigationController = UINavigationController(rootViewController: scheduleTableViewController)
        rosterNavigationController = UINavigationController(rootViewController: rosterCollectionViewController)

        homeCollectionViewController.delegate = self
        scheduleTableViewController.delegate = self
        rosterCollectionViewController.delegate = self

        //Set default screen to be Home
        currentNavigationController = homeNavigationController

        view.addSubview(currentNavigationController.view)
        addChild(currentNavigationController)
        currentNavigationController.didMove(toParent: self)
    }

    func configureMenuController() {
        if menuController == nil {
            menuController = MenuViewController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }

    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        if shouldExpand {
            //show menu
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.currentNavigationController.view.frame.origin.x = self.currentNavigationController.view.frame.width - 80
            }) { (_) in
                print("Out")
                self.currentNavigationController.topViewController?.view.isUserInteractionEnabled = false
            }
        } else {
            //hide menu
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.currentNavigationController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption,
                          menuOption.description != self.currentNavigationController.children[0].navigationItem.title!
                else { return }

                self.didSelectMenuOption(menuOption: menuOption)

                print("in")
                self.currentNavigationController.topViewController?.view.isUserInteractionEnabled = true
            }
        }
    }

    func didSelectMenuOption(menuOption: MenuOption) {
        currentNavigationController.view.removeFromSuperview()
        currentNavigationController.removeFromParent()

        switch menuOption {
        case .Home:
            currentNavigationController = homeNavigationController
        case .Schedule:
            currentNavigationController = scheduleNavigationController
        case .Roster:
            currentNavigationController = rosterNavigationController
        }

        view.addSubview(currentNavigationController.view)
        addChild(currentNavigationController)
        currentNavigationController.didMove(toParent: self)
    }

}

extension MenuContainerViewController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }

        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
