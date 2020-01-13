//
//  AllUsersTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/13/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class AllUsersTableViewController: UITableViewController {

    // MARK: Properties

    private var allUsers: [AppUser] = []
    public var delegate: HomeControllerDelegate?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
        setupTableView()
        fetchAllUsers()
    }

    // MARK: Config

    private func setupNavigationController() {
        navigationItem.title = "All Users"

        let menuButtonImage: UIImage?

        if #available(iOS 13.0, *){
            menuButtonImage = UIImage(systemName: "line.horizontal.3")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        } else {
            menuButtonImage = UIImage(named: "MenuIconBlack")?.withRenderingMode(.alwaysOriginal)
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(menuButtonTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.register(AllUsersTableViewCell.self, forCellReuseIdentifier: "AllUsersTableViewCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(fetchAllUsers), for: .valueChanged)
        tableView.tableFooterView = UIView()
    }

    @objc private func fetchAllUsers() {
        AdminHelper().getAllUsers(completion: { (users, error) in
            self.allUsers = users
            DispatchQueue.main.async {
                self.tableView.reloadData()
                let allUsersTableViewFooter = AllUsersTableViewFooter()
                allUsersTableViewFooter.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50.0)
                allUsersTableViewFooter.set(with: users.count)
                self.tableView.tableFooterView = allUsersTableViewFooter
                self.tableView.refreshControl?.endRefreshing()
            }
        })
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllUsersTableViewCell", for: indexPath) as! AllUsersTableViewCell
        cell.selectionStyle = .none
        cell.set(with: allUsers[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

}
