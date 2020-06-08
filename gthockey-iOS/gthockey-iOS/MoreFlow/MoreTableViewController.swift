//
//  MoreTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/27/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var seasonArray: [Season] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.gthBackgroundColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        let moreTableViewFooter = MoreTableViewFooter()
        tableView.tableFooterView = moreTableViewFooter
        moreTableViewFooter.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 32.0)
        
        fetchSeasons()
    }
    
    // MARK: Private Functions
    
    @objc private func fetchSeasons() {
        ContentManager().getSeasons() { response in
            self.seasonArray = response.sorted { $0.year < $1.year }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return seasonArray.count
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 3
        case 4:
            return 3
        case 5:
            return 1
        default: break
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.font = UIFont.DINAlternate.bold.font(size: 20.0)
        cell.backgroundColor = UIColor.gthBackgroundColor
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = seasonArray[indexPath.row].name
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Student Board"
            case 1:
                cell.textLabel?.text = "Coaching Staff"
            default: break
            }
        case 2:
            cell.textLabel?.text = "Contact Team"
        case 3:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Visit us on Instagram"
            case 1:
                cell.textLabel?.text = "Visit us on Twitter"
            case 2:
                cell.textLabel?.text = "Visit us on Facebook"
            default: break
            }
        case 4:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Buzz"
            case 1:
                cell.textLabel?.text = "Heritage T"
            case 2:
                cell.textLabel?.text = "Ramblin' Reck"
            default: break
            }
        case 5:
            cell.textLabel?.text = "Go to Admin Menu"
        default: break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "All Seasons"
        case 1:
            return "Front Office"
        case 2:
            return "Contact"
        case 3:
            return "Social Media"
        case 4:
            return "App Icon"
        case 5:
            return "Admin"
        default: break
        }
        
        return ""
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        switch indexPath.section {
        case 0:
            let scheduleLayout = UICollectionViewFlowLayout()
            scheduleLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 24.0, right: 0.0)
            let scheduleCollectionViewController = ScheduleCollectionViewController(collectionViewLayout: scheduleLayout)
            scheduleCollectionViewController.seasonID = seasonArray[indexPath.row].id
            scheduleCollectionViewController.seasonString = seasonArray[indexPath.row].name
            navigationController?.pushViewController(scheduleCollectionViewController, animated: true)
        case 1:
            let boardAndCoachesLayout = UICollectionViewFlowLayout()
            boardAndCoachesLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 0.0, bottom: 24.0, right: 0.0)
            
            switch indexPath.row {
            case 0:
                let studentBoardCollectionViewController = StudentBoardCollectionViewController(collectionViewLayout: boardAndCoachesLayout)
                studentBoardCollectionViewController.navigationItem.title = "Student Board"
                navigationController?.pushViewController(studentBoardCollectionViewController, animated: true)
            case 1:
                let coachingStaffCollectionViewController = CoachingStaffCollectionViewController(collectionViewLayout: boardAndCoachesLayout)
                coachingStaffCollectionViewController.navigationItem.title = "Coaching Staff"
                navigationController?.pushViewController(coachingStaffCollectionViewController, animated: true)
            default: break
            }
        case 2:
            let email = "georgiatechhockey@gmail.com"
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            }
        case 3:
            switch indexPath.row {
            case 0:
                openSocialMedia(with: NSURL(string: "instagram://user?username=gthockey")!, NSURL(string: "https://instagram.com/gthockey")!)
            case 1:
                openSocialMedia(with: NSURL(string: "twitter://user?screen_name=GT_Hockey")!, NSURL(string: "https://twitter.com/GT_Hockey")!)
            case 2:
                openSocialMedia(with: NSURL(string: "fb://profile/85852244494")!, NSURL(string: "https://facebook.com/GeorgiaTechHockey")!)
            default: break
            }
        case 4:
            var appIcon: AppIcon?

            switch indexPath.row {
            case 0:
                appIcon = .Buzz
            case 1:
                appIcon = .HeritageT
            case 2:
                appIcon = .RamblinReck
            default: break
            }
            
            AppIconManager().switchAppIcon(to: appIcon ?? .Buzz, completion: { error in
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
        case 5:
            let adminTableViewController = AdminTableViewController()
            adminTableViewController.navigationItem.title = "Admin"
            navigationController?.pushViewController(adminTableViewController, animated: true)
        default: break
        }
    }
        
    // MARK: Private Functions
        
    private func openSocialMedia(with appURL: NSURL, _ webURL: NSURL) {
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
             application.open(appURL as URL)
        } else {
             application.open(webURL as URL)
        }
    }

}
