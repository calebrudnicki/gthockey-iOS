//
//  ScheduleTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {

    private let reuseIdentifier = "cell"
    private var completedGameArray: [Game] = []
    private var upcomingGameArray: [Game] = []
    private let cellHeight = UIScreen.main.bounds.height * 0.8

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Schedule"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupTableView()
        fetchSchedule()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return completedGameArray.count
        default:
            return upcomingGameArray.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ScheduleTableViewCell

        switch indexPath.section {
        case 0:
            cell.set(with: completedGameArray[indexPath.row])
        default:
            cell.set(with: upcomingGameArray[indexPath.row])
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Completed"
        default:
            return "Upcoming"
        }
    }

}

// MARK: - Private Methods

private extension ScheduleTableViewController {

    private func setupTableView() {
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.setEditing(false, animated: false)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(fetchSchedule), for: .valueChanged)
    }

    @objc private func fetchSchedule() {
        completedGameArray = []
        upcomingGameArray = []
        
        let parser = JSONParser()
        parser.getSchedule() { response in
            for game in response {
                if game.getIsReported() {
                    self.completedGameArray.append(game)
                } else {
                    self.upcomingGameArray.append(game)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }

}
