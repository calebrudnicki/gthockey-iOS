//
//  AllUsersTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/13/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

enum UserFilter {

    case validFCMToken
    case validAppVersion
    case adminUsers
    case none

    var description: String {
        switch self {
        case .validFCMToken: return "Users with valid FCM Token"
        case .validAppVersion: return "Users with valid app version"
        case .adminUsers: return "Admin users"
        case .none: return "All users"
        }
    }

}

class AllUsersTableViewController: UITableViewController {

    // MARK: Properties

    private var allUsers: [AppUser] = []
    private var currentlyDisplayedUsers: [AppUser] = []
    private var currentFilterSelected: UserFilter = .none
    private let filtersArray: [UserFilter] = [.validFCMToken, .validAppVersion, .adminUsers, .none]
    private var menuView: BTNavigationDropdownMenu?
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
        let arrowButtonImage: UIImage?

        if #available(iOS 13.0, *){
            menuButtonImage = UIImage(systemName: "line.horizontal.3")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
            arrowButtonImage = UIImage(systemName: "chevron.down")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        } else {
            menuButtonImage = UIImage(named: "MenuIconBlack")?.withRenderingMode(.alwaysOriginal)
            arrowButtonImage = UIImage(named: "DownArrowBlack")?.withRenderingMode(.alwaysOriginal)
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(menuButtonTapped))
        menuView?.arrowImage = arrowButtonImage
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.register(AllUsersTableViewCell.self, forCellReuseIdentifier: "AllUsersTableViewCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(fetchAllUsers), for: .valueChanged)
        tableView.tableFooterView = UIView()
    }

    @objc private func fetchAllUsers() {
        UserHelper().getAllUsers(completion: { users in
            self.allUsers = self.filterAllUsers(for: self.currentFilterSelected, with: users)

            DispatchQueue.main.async {
                self.menuView = BTNavigationDropdownMenu(navigationController: self.navigationController,
                                                         containerView: self.navigationController!.view,
                                                         title: self.currentFilterSelected.description,
                                                         items: self.filtersArray.map { $0.description })

                self.menuView?.cellHeight = 52.0
                self.menuView?.cellSelectionColor = .techGold
                self.menuView?.shouldKeepSelectedCellColor = true
                self.menuView?.cellBackgroundColor = .techNavy
                self.menuView?.cellTextLabelColor = .white
                self.menuView?.selectedCellTextLabelColor = .techNavy
                self.menuView?.cellTextLabelFont = UIFont(name: "HelveticaNeue-Light", size: 16.0)
                self.menuView?.arrowPadding = 15.0
                self.menuView?.animationDuration = 0.5
                if #available(iOS 13.0, *) {
                    self.menuView?.arrowTintColor = .label
                } else {
                    self.menuView?.arrowTintColor = .black
                }

                self.menuView?.didSelectItemAtIndexHandler = { [weak self] (indexPath: Int) -> () in
                    self?.currentFilterSelected = self?.filtersArray[indexPath] ?? .none
                    self?.fetchAllUsers()
                }
                self.navigationItem.titleView = self.menuView

                self.tableView.reloadData()
                let allUsersTableViewFooter = AllUsersTableViewFooter()
                allUsersTableViewFooter.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50.0)
                allUsersTableViewFooter.set(with: self.allUsers.count)
                self.tableView.tableFooterView = allUsersTableViewFooter
                self.tableView.refreshControl?.endRefreshing()
            }
        })
    }

    private func filterAllUsers(for filter: UserFilter, with users: [AppUser]) -> [AppUser] {
        var currentUsers = users

        switch filter {
        case .validFCMToken:
            currentUsers = currentUsers.filter { $0.getFCMToken() != "No FCM token" }
            currentUsers = currentUsers.sorted { $0.getFirstName() < $1.getFirstName() }
        case .validAppVersion:
            currentUsers = currentUsers.filter { $0.getAppVersion() != "No app version" }
            currentUsers = currentUsers.sorted { $0.getAppVersion() < $1.getAppVersion() }
        case .adminUsers:
            currentUsers = currentUsers.filter { $0.getIsAdmin() == true }
            currentUsers = currentUsers.sorted { $0.getFirstName() < $1.getFirstName() }
        case .none: break
        }

        return currentUsers
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
        return 180.0
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

    @objc private func segmentedControllerChanged() {
        tableView.reloadData()
    }

}
