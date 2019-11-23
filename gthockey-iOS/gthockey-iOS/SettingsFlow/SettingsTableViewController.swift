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
    private var firstName: String?
    private var lastName: String?
    private var saveButton: UIBarButtonItem?
    public var delegate: HomeControllerDelegate?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Settings"

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
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        saveButton?.isEnabled = false
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.navigationBar.prefersLargeTitles = true

        setupTableView()
        fetchUserInfo()
    }

    // MARK: Config

    private func setupTableView() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.allowsSelection = false

        let settingsTableViewFooter = SettingsTableViewFooter()
        settingsTableViewFooter.delegate = self
        settingsTableViewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 75.0)
        tableView.tableFooterView = settingsTableViewFooter
    }

    @objc private func fetchUserInfo() {
        let authentificator = Authentificator()
        authentificator.getUserProperties(completion: { propertiesDictionary in
            self.firstName = propertiesDictionary["firstName"] ?? ""
            self.lastName = propertiesDictionary["lastName"] ?? ""
            self.userProperties = propertiesDictionary
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProperties.keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        switch indexPath.row {
        case 0:
            cell.set(with: "First Name", userProperties["firstName"] ?? "")
        default:
            cell.set(with: "Last Name", userProperties["lastName"] ?? "")
        }
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }

    @objc private func saveButtonTapped() {
        if let firstName = firstName, let lastName = lastName,
            firstName != userProperties["firstName"] || lastName != userProperties["lastName"] {
            let authentificator = Authentificator()
            authentificator.updateUserProperties(with: firstName, lastName: lastName, completion: { result in
                if result {
                    self.userProperties["firstName"] = firstName
                    self.userProperties["lastName"] = lastName
                    self.saveButton?.isEnabled = false
                }
            })
        }
    }

}

extension SettingsTableViewController: SettingsTableViewCellDelegate {

    func updatedValue(to newValue: String, for category: String) {
        saveButton?.isEnabled = true
        switch category {
        case "First Name":
            firstName = newValue
        case "Last Name":
            lastName = newValue
        default:
            break
        }
    }

}

extension SettingsTableViewController: SettingsTableViewFooterDelegate {

    func signoutButtonTapped() {
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