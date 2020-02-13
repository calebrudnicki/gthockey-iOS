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

    private var allUsersWithLastLogin: [AppUser] = []
    private var allUsersWithoutLastLogin: [AppUser] = []
    private let segmentedController = UISegmentedControl()
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

        segmentedController.insertSegment(withTitle: "With Login", at: 0, animated: true)
        segmentedController.insertSegment(withTitle: "Without Login", at: 1, animated: true)
        segmentedController.selectedSegmentIndex = 0
        segmentedController.addTarget(self, action: #selector(segmentedControllerChanged), for: .valueChanged)
        navigationItem.titleView = segmentedController
    }

    private func setupTableView() {
        tableView.register(AllUsersTableViewCell.self, forCellReuseIdentifier: "AllUsersTableViewCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(fetchAllUsers), for: .valueChanged)
        tableView.tableFooterView = UIView()
    }

    @objc private func fetchAllUsers() {
        AdminHelper().getAllUsers(completion: { (usersWithLastLogin, usersWithoutLastLogin, error) in
            self.allUsersWithLastLogin = usersWithLastLogin

//            self.allUsersWithLastLogin.sort {
//                DateHelper().formatDate(from: $0.getLastLogin(), withTime: true) < DateHelper().formatDate(from: $1.getLastLogin(), withTime: true)
//            }

            self.allUsersWithoutLastLogin = usersWithoutLastLogin

            DispatchQueue.main.async {
                self.tableView.reloadData()
                let allUsersTableViewFooter = AllUsersTableViewFooter()
                allUsersTableViewFooter.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50.0)
                allUsersTableViewFooter.set(with: usersWithLastLogin.count + usersWithoutLastLogin.count)
                self.tableView.tableFooterView = allUsersTableViewFooter
                self.tableView.refreshControl?.endRefreshing()
            }
        })
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            return allUsersWithLastLogin.count
        default:
            return allUsersWithoutLastLogin.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllUsersTableViewCell", for: indexPath) as! AllUsersTableViewCell
        cell.selectionStyle = .none
        switch segmentedController.selectedSegmentIndex {
        case 0:
            cell.set(with: allUsersWithLastLogin[indexPath.row])
        default:
            cell.set(with: allUsersWithoutLastLogin[indexPath.row])
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136.0
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

    @objc private func segmentedControllerChanged() {
        tableView.reloadData()
    }

}
