//
//  AdminTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 6/4/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

//import UIKit
//
//class AdminTableViewController: UITableViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.backgroundColor = UIColor.gthBackgroundColor
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
//        tableView.tableFooterView = UIView()
//    }
//
//    // MARK: - Table view data source
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
//        cell.textLabel?.font = UIFont.DINAlternate.bold.font(size: 16.0)
//        cell.backgroundColor = UIColor.moreCellBackgroundColor
//        cell.textLabel?.textColor = UIColor.moreCellTitleColor
//        
//        switch indexPath.row {
//        case 0:
//            cell.textLabel?.text = "Notification Center"
//        default: break
//        }
//
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    
//        switch indexPath.row {
//        case 0:
//            let notificationCenterViewController = NotificationCenterViewController()
//            notificationCenterViewController.navigationItem.title = "Notifications"
//            navigationController?.pushViewController(notificationCenterViewController, animated: true)
//        default: break
//        }
//    }
//
//}
