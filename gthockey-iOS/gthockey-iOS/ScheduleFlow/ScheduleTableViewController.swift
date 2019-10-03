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
    private var gameArray: [Game] = []
    private let cellHeight = UIScreen.main.bounds.height * 0.8

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Schedule"
        navigationController?.navigationBar.prefersLargeTitles = true

        self.tableView!.register(ScheduleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        let parser = JSONParser()
        parser.getSchedule() { response in
            self.gameArray = response
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ScheduleTableViewCell
        cell.set(with: gameArray[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }

}
