//
//  AdminUsersTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/12/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class AdminUsersTableViewController: UITableViewController {

    // MARK: Properties

    private var adminUsers: [String] = []
    private let cellHeight = UIScreen.main.bounds.height * 0.8
    public var delegate: HomeControllerDelegate?
    private let segmentedController = UISegmentedControl()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
        setupTableView()
        fetchAdminUsers()
    }

    // MARK: Config

    private func setupNavigationController() {
        navigationItem.title = "Admin Users"

        let menuButtonImage: UIImage?
        let cartButtonImage: UIImage?

        if #available(iOS 13.0, *){
            menuButtonImage = UIImage(systemName: "line.horizontal.3")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
            cartButtonImage = UIImage(systemName: "cart.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        } else {
            menuButtonImage = UIImage(named: "MenuIconBlack")?.withRenderingMode(.alwaysOriginal)
            cartButtonImage = UIImage(named: "CartIconBlack")?.withRenderingMode(.alwaysOriginal)
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(menuButtonTapped))
        // MARK: Uncomment for cart
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(image: cartButtonImage,
        //                                                           style: .plain,
        //                                                           target: self,
        //                                                           action: #selector(cartButtonTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AdminUsersTableViewCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(fetchAdminUsers), for: .valueChanged)

        let adminUsersTableViewFooter = AdminUsersTableViewFooter()
        adminUsersTableViewFooter.delegate = self
        adminUsersTableViewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 75.0)
        tableView.tableFooterView = adminUsersTableViewFooter
    }

    @objc private func fetchAdminUsers() {
        AdminHelper().getAdminUsers(completion: { (admins, error) in
            self.adminUsers = admins
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.sectionHeaderHeight = 32.0
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
                self.tableView.refreshControl?.endRefreshing()
            }
        })
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminUsersTableViewCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = adminUsers[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Editing")
//            AdminHelper.remove(adminUsers[indexPath.row], completion: { result in
//                if result {
//                    self.adminUsers.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                } else {
//                    let alert = UIAlertController(title: "Failed to remove admin user",
//                                                  message: "We were unable to remove this user as an admin. For more help, you can complete this in the Firebase console online.
//                                                  preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true, completion: nil)
//                }
//            })
        }
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

}

extension AdminUsersTableViewController: AdminUsersTableViewFooterDelegate {

    func addAdminUserButtonTapped(with addAdminUserButton: PillButton) {
        AdminHelper().add(email: "fakeemail@gmail.com") { (result) in
            if result {
                addAdminUserButton.isLoading = false
                self.fetchAdminUsers()
            }
        }
    }


//    func signoutButtonTapped(with signoutButton: PillButton) {
//        let alert = UIAlertController(title: "What is the email that you want to add?", message: nil, preferredStyle: .alert)
////        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
////            AuthenticationHelper().signOut { (result, error) in
////                if result {
////                    let welcomeViewController = WelcomeViewController()
////                    welcomeViewController.modalPresentationStyle = .fullScreen
////                    self.present(welcomeViewController, animated: true, completion: nil)
////                } else {
////                    let alert = UIAlertController(title: "Sign out failed",
////                                                  message: error?.localizedDescription,
////                                                  preferredStyle: .alert)
////                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
////                    self.present(alert, animated: true, completion: nil)
////                }
////            }
////        }))
////        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { _ in
////            signoutButton.isLoading = false
////        }))
//        self.present(alert, animated: true, completion: nil)
//    }

}
