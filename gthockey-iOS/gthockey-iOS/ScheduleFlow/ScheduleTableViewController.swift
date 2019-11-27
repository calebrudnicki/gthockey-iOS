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

class ScheduleTableViewController: UITableViewController {

    // MARK: Properties

    private var completedGameArray: [Game] = []
    private var upcomingGameArray: [Game] = []
    private let cellHeight = UIScreen.main.bounds.height * 0.8
    public var delegate: HomeControllerDelegate?

    private let segmentedController = UISegmentedControl()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
        setupTableView()
        fetchSchedule()
    }

    // MARK: Config

    private func setupNavigationController() {
        navigationItem.title = "Schedule"

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

        segmentedController.insertSegment(withTitle: "Upcoming", at: 0, animated: true)
        segmentedController.insertSegment(withTitle: "Completed", at: 1, animated: true)
        segmentedController.selectedSegmentIndex = 0
        segmentedController.addTarget(self, action: #selector(segmentedControllerChanged), for: .valueChanged)
        navigationItem.titleView = segmentedController
    }

    private func setupTableView() {
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(fetchSchedule), for: .valueChanged)
        tableView.tableFooterView = UIView()
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

    // MARK: UITableViewDelegate / UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            return upcomingGameArray.count
        default:
            return completedGameArray.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell

        switch segmentedController.selectedSegmentIndex {
        case 0:
            cell.set(with: upcomingGameArray[indexPath.row])
        default:
            cell.set(with: completedGameArray[indexPath.row])
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Get Directions to the Rink", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch self.segmentedController.selectedSegmentIndex {
            case 0:
                self.fetchGame(with: self.upcomingGameArray[indexPath.row].getID(), completion: { (opponent, rink) in
                    self.openMaps(with: rink)
                })
            default:
                self.fetchGame(with: self.completedGameArray[indexPath.row].getID(), completion: { (opponent, rink) in
                    self.openMaps(with: rink)
                })
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }

    @objc private func cartButtonTapped() {
        let cartTableViewController = CartTableViewController()
        present(cartTableViewController, animated: true, completion: nil)
    }

    @objc private func segmentedControllerChanged() {
        tableView.reloadData()
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
