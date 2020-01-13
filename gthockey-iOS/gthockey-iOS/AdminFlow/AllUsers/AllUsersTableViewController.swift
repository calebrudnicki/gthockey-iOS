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

    private var allUsers: [String] = []
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AllUsersTableViewCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(fetchAllUsers), for: .valueChanged)
        tableView.tableFooterView = UIView()
    }

    @objc private func fetchAllUsers() {
        AdminHelper().getAllUsers(completion: { (users, error) in
            self.allUsers = users
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        })
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllUsersTableViewCell", for: indexPath) as! UITableViewCell
        cell.selectionStyle = .none
        cell.textLabel?.text = allUsers[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            AdminHelper().remove(adminUsers[indexPath.row], completion: { result in
//                if result {
//                    self.adminUsers.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                } else {
//                    let alert = UIAlertController(title: "Failed to remove admin user",
//                                                  message: "We were unable to remove this user as an admin. For more help, you can complete this in the Firebase console online.",
//                                                  preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true, completion: nil)
//                }
//            })
//        }
//    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

}

//extension AdminUsersTableViewController: AdminUsersTableViewFooterDelegate {
//
//    func addAdminUserButtonTapped(with addAdminUserButton: PillButton) {
//        let alertController = UIAlertController(title: "Add admin user", message: "", preferredStyle: .alert)
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Enter email"
//        }
//        let addAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
//            let firstTextField = alertController.textFields![0] as UITextField
//            AdminHelper().add(email: firstTextField.text ?? "georgiatechhockey@gmail.com") { (result) in
//                if result {
//                    addAdminUserButton.isLoading = false
//                    self.fetchAdminUsers()
//                }
//            }
//        })
//        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
//            addAdminUserButton.isLoading = false
//        })
//
//        alertController.addAction(addAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//}
