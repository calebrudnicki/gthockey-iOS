//
//  ScheduleTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import MapKit

class ScheduleTableViewController: UITableViewController {

    private let reuseIdentifier = "cell"
    private var completedGameArray: [Game] = []
    private var upcomingGameArray: [Game] = []
    private let cellHeight = UIScreen.main.bounds.height * 0.8

    var delegate: HomeControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Schedule"

        let menuButtonImage: UIImage?
        if traitCollection.userInterfaceStyle == .dark {
            menuButtonImage = UIImage(named: "MenuIconWhite")?.withRenderingMode(.alwaysOriginal)
        } else {
            menuButtonImage = UIImage(named: "MenuIconBlack")?.withRenderingMode(.alwaysOriginal)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(menuButtonTapped))
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Get Directions to the Rink", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch indexPath.section {
            case 0:
                self.fetchGame(with: self.completedGameArray[indexPath.row].getID(), completion: { (opponent, rink) in
                    self.openMaps(with: rink)
                })
            default:
                self.fetchGame(with: self.upcomingGameArray[indexPath.row].getID(), completion: { (opponent, rink) in
                    self.openMaps(with: rink)
                })
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: Private Methods

extension ScheduleTableViewController {

    private func setupTableView() {
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(fetchSchedule), for: .valueChanged)
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = 0.0
    }

    @objc private func fetchSchedule() {
        let parser = JSONParser()
        parser.getSchedule() { response in
            self.completedGameArray = []
            self.upcomingGameArray = []

            for game in response {
                if game.getIsReported() {
                    self.completedGameArray.append(game)
                } else {
                    self.upcomingGameArray.append(game)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.sectionHeaderHeight = 32.0
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }

    private func fetchGame(with id: Int, completion: @escaping (Team, Rink) -> Void) {
        let parser = JSONParser()
        parser.getGame(with: id) { (opponent, rink) in
            completion(opponent, rink)
        }
    }

    private func openMaps(with rink: Rink) {
        let rinkCoordinates = findLocation(from: rink.getMapsURL()).coordinate
        let coordinateRegion = MKCoordinateRegion(center: rinkCoordinates,
                                                  latitudinalMeters: 1000,
                                                  longitudinalMeters: 1000)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: coordinateRegion.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: coordinateRegion.span)
        ]
        let placemark = MKPlacemark(coordinate: rinkCoordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = rink.getName()
        mapItem.openInMaps(launchOptions: options)
    }

    private func findLocation(from url: URL) -> CLLocation {
        var latitude: Float?
        var longitude: Float?

        if let latitudeString = url.absoluteString.slice(from: "@", to: ",") {
            latitude = Float(latitudeString)
        }

        if let longitudeString = url.absoluteString.slice(from: ",", to: ",") {
            longitude = Float(longitudeString)
        }

        return CLLocation(latitude: CLLocationDegrees(exactly: latitude ?? 33.7756)!,
                          longitude: CLLocationDegrees(exactly: longitude ?? -84.3963)!)
    }

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }

}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
