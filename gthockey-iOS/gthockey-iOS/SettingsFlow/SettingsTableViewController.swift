//
//  SettingsTableViewController.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 11/20/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    // MARK: Properties

    private var userProperties: [String : String] = [:]
    public var delegate: HomeControllerDelegate?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Settings"

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: cartButtonImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(cartButtonTapped))
        navigationController?.navigationBar.prefersLargeTitles = true

        setupTableView()
        fetchUserInfo()
    }

    // MARK: Config

    private func setupTableView() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")

        let signoutButton = PillButton(title: "Sign Out", backgroundColor: .white, borderColor: .lossRed, isEnabled: true)
        signoutButton.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        signoutButton.addTarget(self, action: #selector(signoutButtonTapped), for: .touchUpInside)
        tableView.tableFooterView = signoutButton

//        tableView.sectionHeaderHeight = 0.0
    }

    @objc private func fetchUserInfo() {
        let authentificator = Authentificator()
        authentificator.getUserProperties(completion: { propertiesDictionary in
//            print(propertiesDictionary["firstName"])
//            print(propertiesDictionary["lastName"])
            self.userProperties = propertiesDictionary
            DispatchQueue.main.async {
                self.tableView.reloadData()
//                self.tableView.sectionHeaderHeight = 32.0
//                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
//                self.tableView.refreshControl?.endRefreshing()
            }
        })
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        default:
//            return 0
//        }
        return userProperties.keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        switch indexPath.row {
        case 0:
//            cell.set(with: completedGameArray[indexPath.row])
             cell.set(with: "Caleb")
        default:
//            cell.set(with: upcomingGameArray[indexPath.row])
             cell.set(with: "Rudnicki")
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return "User Settings"
//        default:
//            return "Upcoming"
//        }
//    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }

    @objc private func cartButtonTapped() {
        let cartTableViewController = CartTableViewController()
        present(cartTableViewController, animated: true, completion: nil)
    }

    @objc private func signoutButtonTapped() {
        let alert = UIAlertController(title: "Are you sure you want to sign out?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let authentificator = Authentificator()
            authentificator.signOut { (result, error) in
                if result {
                    let welcomeViewController = WelcomeViewController()
                    welcomeViewController.modalPresentationStyle = .fullScreen
                    self.present(welcomeViewController, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Sign Out Failed",
                                              message: error?.localizedDescription,
                                              preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
