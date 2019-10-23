//
//  MenuTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/23/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    private let reuseIdentifier = "menuOptionCell"
    var delegate: HomeControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .techNavy

        tableView.frame.size.width = view.frame.width - 80
        tableView.frame.size.height = view.frame.height

        tableView.backgroundColor = .techNavy
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        let menuTableViewHeader = MenuTableViewHeader()
        tableView.tableHeaderView = menuTableViewHeader
        menuTableViewHeader.frame = CGRect(x: 0, y: 0, width: view.frame.width - 80, height: 75.0)

        let menuTableViewFooter = MenuTableViewFooter()
        tableView.tableFooterView = menuTableViewFooter
        menuTableViewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width - 80, height: 25.0)

        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuTableViewCell
        cell.set(with: MenuOption(rawValue: indexPath.row)!)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
