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

    public var delegate: HomeControllerDelegate?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    // MARK: Config

    private func setupTableView() {
        tableView.backgroundColor = .gthBackgroundColor
        tableView.register(SettingsTextFieldTableViewCell.self, forCellReuseIdentifier: "SettingsTextFieldTableViewCell")
        tableView.register(SettingsSwitchControlTableViewCell.self, forCellReuseIdentifier: "SettingsSwitchControlTableViewCell")
        tableView.register(SettingsIconTableViewCell.self, forCellReuseIdentifier: "SettingsIconTableViewCell")
        tableView.allowsSelection = false

        let settingsTableViewFooter = SettingsTableViewFooter()
        settingsTableViewFooter.delegate = self
        settingsTableViewFooter.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 75.0)
        self.tableView.tableFooterView = settingsTableViewFooter
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return AppIcon.Buzz.count()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTextFieldTableViewCell", for: indexPath) as! SettingsTextFieldTableViewCell
            switch indexPath.row {
            case 0:
                cell.set(with: "Name", value: UserPropertyManager().displayName, isEditable: false)
            case 1:
                cell.set(with: "Email", value: UserPropertyManager().email, isEditable: false)
            case 2:
                cell.set(with: "User ID", value: UserPropertyManager().id, isEditable: false)
            default:
                break
            }
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsSwitchControlTableViewCell", for: indexPath) as! SettingsSwitchControlTableViewCell
            cell.set(with: "Allow notifications",
                     subtitle: "Trouble? Visit GT Hockey in Apple's Settings app")
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsIconTableViewCell", for: indexPath) as! SettingsIconTableViewCell
            switch indexPath.row {
            case 0:
                cell.set(to: .Buzz, iconName: "Buzz", isSelected: AppIconManager().isDefaultIcon(.Buzz))
            case 1:
                cell.set(to: .HeritageT, iconName: "Heritage T", isSelected: AppIconManager().isDefaultIcon(.HeritageT))
            default:
                cell.set(to: .RamblinReck, iconName: "Ramblin' Reck", isSelected: AppIconManager().isDefaultIcon(.RamblinReck))
            }
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
        case 1:
            return "Notifications"
        default:
            return "App Icon"
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

}

extension SettingsTableViewController: SettingsTextFieldTableViewCellDelegate {

    func updatedValue(to newValue: String, for category: String) {}

}

extension SettingsTableViewController: SettingsSwitchControlTableViewCellDelegate {

    func switchControlToggled(to value: Bool) {
        if value {
            PushNotificationManager().registerForPushNotifications()
        } else {
            PushNotificationManager().unregisterForPushNotifications()
        }
    }

}

extension SettingsTableViewController: SettingsIconTableViewCellDelegate {

    func didSelectCell(with appIcon: AppIcon) {
        AppIconManager().switchAppIcon(to: appIcon, completion: { error in
            if error != nil {
                let alert = UIAlertController(title: "App icon switch failed",
                                          message: error?.localizedDescription,
                                          preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.tableView.reloadSections(IndexSet(integer: 2), with: UITableView.RowAnimation.none)
            }
        })
    }

}

extension SettingsTableViewController: SettingsTableViewFooterDelegate {

    func signoutButtonTapped(with signoutButton: PillButton) {
        let alert = UIAlertController(title: "Are you sure you want to sign out?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            AuthenticationManager().signOut { error in
                if let error = error {
                    //Sign out failed
                    let alert = UIAlertController(title: "Sign out failed",
                                                  message: error.localizedDescription,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }

                //Sign out successful
                let mainSignInViewController = MainSignInViewController()
                mainSignInViewController.modalPresentationStyle = .fullScreen
                self.present(mainSignInViewController, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { _ in
            signoutButton.isLoading = false
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
