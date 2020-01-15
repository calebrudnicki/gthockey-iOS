//
//  MenuTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/23/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    // MARK; Properties

    public var delegate: HomeControllerDelegate!
    private var isShowingAdminMenu = false

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .techCream
        tableView.frame.size.width = view.frame.width - 80
        tableView.frame.size.height = view.frame.height
        tableView.backgroundColor = .techCream
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")

        let menuTableViewHeader = MenuTableViewHeader()
        tableView.tableHeaderView = menuTableViewHeader
        menuTableViewHeader.frame = CGRect(x: 0, y: 0, width: view.frame.width - 80, height: 75.0)

        let menuTableViewFooter = MenuTableViewFooter()
        menuTableViewFooter.delegate = self
        tableView.tableFooterView = menuTableViewFooter
        menuTableViewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width - 80, height: 115.0)

        updateViewConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShowingAdminMenu ? AdminMenuOption.AdminUsers.count() :
                                    MainMenuOption.Home.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        if isShowingAdminMenu {
            cell.set(with: AdminMenuOption(rawValue: indexPath.row)!)
        } else {
            cell.set(with: MainMenuOption(rawValue: indexPath.row)!)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowingAdminMenu {
            let adminMenuOption = AdminMenuOption(rawValue: indexPath.row)
            delegate?.handleMenuToggle(forAdminMenuOption: adminMenuOption)
        } else {
            let mainMenuOption = MainMenuOption(rawValue: indexPath.row)
            delegate?.handleMenuToggle(forMainMenuOption: mainMenuOption)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension MenuTableViewController: MenuTableViewFooterDelegate {

    func toggleAdminButtonTapped(with toggleAdminButton: UIButton) {
        isShowingAdminMenu = !isShowingAdminMenu
        toggleAdminButton.setTitle(isShowingAdminMenu ? "Switch to main menu" : "Switch to admin menu", for: .normal)
        tableView.reloadData()
    }

}
