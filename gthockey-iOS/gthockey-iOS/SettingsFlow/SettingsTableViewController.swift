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

    private var userProperties: [String : Any] = [:]
    private var firstName: String?
    private var lastName: String?
    private var email: String?

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
        tableView.register(SettingsTextFieldTableViewCell.self, forCellReuseIdentifier: "SettingsTextFieldTableViewCell")
        tableView.register(SettingsSwitchControlTableViewCell.self, forCellReuseIdentifier: "SettingsSwitchControlTableViewCell")
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }

    @objc private func fetchUserInfo() {
        AuthenticationHelper().getUserProperties(completion: { propertiesDictionary in
            self.firstName = propertiesDictionary["firstName"] as? String
            self.lastName = propertiesDictionary["lastName"] as? String
            self.email = propertiesDictionary["email"] as? String
            self.userProperties = propertiesDictionary

            DispatchQueue.main.async {
                self.tableView.reloadData()
                let settingsTableViewFooter = SettingsTableViewFooter()
                settingsTableViewFooter.delegate = self
                settingsTableViewFooter.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 75.0)
                self.tableView.tableFooterView = settingsTableViewFooter
            }
        })
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return userProperties.keys.count - 1
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTextFieldTableViewCell", for: indexPath) as! SettingsTextFieldTableViewCell
            switch indexPath.row {
            case 0:
                cell.set(with: "First name", value: userProperties["firstName"] as! String, isEditable: true)
            case 1:
                cell.set(with: "Last name", value: userProperties["lastName"] as! String, isEditable: true)
            case 2:
                cell.set(with: "Email", value: userProperties["email"] as! String, isEditable: false)
            default:
                break
            }
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsSwitchControlTableViewCell", for: indexPath) as! SettingsSwitchControlTableViewCell
            cell.set(with: "Go to settings")
            cell.delegate = self
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Profile"
        default:
            return "Notifications"
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

    @objc private func saveButtonTapped() {
        if let firstName = firstName, let lastName = lastName,
            firstName != userProperties["firstName"] as! String || lastName != userProperties["lastName"] as! String {
            AuthenticationHelper().updateUserProperties(with: firstName, lastName: lastName, completion: { result in
                if result {
                    self.userProperties["firstName"] = firstName
                    self.userProperties["lastName"] = lastName
                    self.saveButton?.isEnabled = false
                }
            })
        }
    }

}

extension SettingsTableViewController: SettingsTextFieldTableViewCellDelegate {

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

extension SettingsTableViewController: SettingsSwitchControlTableViewCellDelegate {

    func cellDidDetechTap() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }

}

extension SettingsTableViewController: SettingsTableViewFooterDelegate {

    func signoutButtonTapped(with signoutButton: PillButton) {
        let alert = UIAlertController(title: "Are you sure you want to sign out?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            AuthenticationHelper().signOut { (result, error) in
                if result {
                    let welcomeViewController = WelcomeViewController()
                    welcomeViewController.modalPresentationStyle = .fullScreen
                    self.present(welcomeViewController, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Sign out failed",
                                                  message: error?.localizedDescription,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { _ in
            signoutButton.isLoading = false
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
