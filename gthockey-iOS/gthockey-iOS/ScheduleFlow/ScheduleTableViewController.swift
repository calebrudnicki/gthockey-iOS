//
//  ScheduleTableViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseFirestore
import BTNavigationDropdownMenu

// MARK: Under Construction

class ScheduleTableViewController: UITableViewController {

    // MARK: Properties

    private var completedGameArray: [Game] = []
    private var upcomingGameArray: [Game] = []
    private var seasonArray: [Season] = []
    private var seasonRecord: String = "0-0-0-0"
    private var currentSeasonIDSelected: Int = 8
    private let cellHeight = UIScreen.main.bounds.height * 0.8
    private var menuView: BTNavigationDropdownMenu?
    public var delegate: HomeControllerDelegate?


    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchSchedule()
        fetchSeasons()
    }

    // MARK: Config

    private func setupTableView() {
        tableView.backgroundColor = .GTBackgroundColor
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(fetchSchedule), for: .valueChanged)
        tableView.tableFooterView = UIView()
    }

    @objc private func fetchSchedule() {
        ContentManager().getSchedule(with: currentSeasonIDSelected) { response in
            self.completedGameArray = []
            self.upcomingGameArray = []

            var wins = 0
            var losses = 0
            var otLosses = 0
            var ties = 0

            for game in response {
                if game.getIsReported() {
                    self.completedGameArray.append(game)
                    switch game.getShortResult() {
                    case "W":
                        wins += 1
                    case "L":
                        losses += 1
                    case "OT":
                        otLosses += 1
                    default:
                        ties += 1
                    }
                } else {
                    self.upcomingGameArray.append(game)
                }
            }

            self.seasonRecord = "\(wins)-\(losses)-\(otLosses)-\(ties)"

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.sectionHeaderHeight = 32.0
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
                self.tableView.refreshControl?.endRefreshing()
                if self.upcomingGameArray.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: false)
                } else {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            }
        }
    }

    @objc private func fetchSeasons() {
        ContentManager().getSeasons() { response in
            self.seasonArray = response.sorted { $0.getYear() < $1.getYear() }

            DispatchQueue.main.async {
                self.menuView = BTNavigationDropdownMenu(navigationController: self.navigationController,
                                                         containerView: self.navigationController!.view,
                                                         title: self.seasonArray[self.seasonArray.count - 1].getName(),
                                                         items: self.seasonArray.map { $0.getName() })

                self.menuView?.cellHeight = 52.0
                self.menuView?.cellSelectionColor = .techGold
                self.menuView?.shouldKeepSelectedCellColor = true
                self.menuView?.cellBackgroundColor = .techNavy
                self.menuView?.cellTextLabelColor = .white
                self.menuView?.selectedCellTextLabelColor = .techNavy
                self.menuView?.cellTextLabelFont = UIFont(name: "HelveticaNeue-Light", size: 16.0)
                self.menuView?.arrowPadding = 15.0
                self.menuView?.animationDuration = 0.5
                if #available(iOS 13.0, *) {
                    self.menuView?.arrowTintColor = .label
                } else {
                    self.menuView?.arrowTintColor = .black
                }

                self.menuView?.didSelectItemAtIndexHandler = { [weak self] (indexPath: Int) -> () in
                    self?.currentSeasonIDSelected = self?.seasonArray[indexPath].getID() ?? 3
                    self?.fetchSchedule()
                }
                self.navigationItem.titleView = self.menuView
            }
        }
    }

    private func fetchGame(with id: Int, completion: @escaping (Team, Rink) -> Void) {
        ContentManager().getGame(with: id) { (opponent, rink) in
            completion(opponent, rink)
        }
    }

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        if completedGameArray.count == 0 || upcomingGameArray.count == 0 {
            return 1
        }
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if completedGameArray.count == 0 {
            return upcomingGameArray.count
        } else if upcomingGameArray.count == 0 {
            return completedGameArray.count
        } else {
            switch section {
            case 0:
                return completedGameArray.count
            default:
                return upcomingGameArray.count
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell

        if completedGameArray.count == 0 {
            cell.set(with: upcomingGameArray[indexPath.row])
        } else if upcomingGameArray.count == 0 {
            cell.set(with: completedGameArray[indexPath.row])
        } else {
            switch indexPath.section {
            case 0:
                cell.set(with: completedGameArray[indexPath.row])
            default:
                cell.set(with: upcomingGameArray[indexPath.row])
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameDetailViewController = ScheduleDetailViewController()

        if completedGameArray.count == 0 {
            self.fetchGame(with: self.upcomingGameArray[indexPath.row].getID(), completion: { (opponent, rink) in
                gameDetailViewController.set(with: self.upcomingGameArray[indexPath.row], opponent, rink)
            })
        } else if upcomingGameArray.count == 0 {
            self.fetchGame(with: self.completedGameArray[indexPath.row].getID(), completion: { (opponent, rink) in
                gameDetailViewController.set(with: self.completedGameArray[indexPath.row], opponent, rink)
            })
        } else {
            switch indexPath.section {
            case 0:
                self.fetchGame(with: self.completedGameArray[indexPath.row].getID(), completion: { (opponent, rink) in
                    gameDetailViewController.set(with: self.completedGameArray[indexPath.row], opponent, rink)
                })
            default:
                self.fetchGame(with: self.upcomingGameArray[indexPath.row].getID(), completion: { (opponent, rink) in
                    gameDetailViewController.set(with: self.upcomingGameArray[indexPath.row], opponent, rink)
                })
            }
        }

        present(gameDetailViewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if completedGameArray.count == 0 {
            return "Upcoming"
        } else if upcomingGameArray.count == 0 {
            return "Season Record: \(seasonRecord)"
        } else {
            switch section {
            case 0:
                return "Season Record: \(seasonRecord)"
            default:
                return "Upcoming"
            }
        }

    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

    @objc private func cartButtonTapped() {
        let cartTableViewController = CartTableViewController()
        present(cartTableViewController, animated: true, completion: nil)
    }

    // MARK: Location

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

}
