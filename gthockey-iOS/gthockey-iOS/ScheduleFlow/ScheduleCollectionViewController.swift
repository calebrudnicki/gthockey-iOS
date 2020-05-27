//
//  ScheduleCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/22/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ScheduleCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private var completedGameArray: [Game] = []
    private var upcomingGameArray: [Game] = []
    private var seasonArray: [Season] = []
    private var seasonRecord: String = "0-0-0-0"

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        fetchSchedule()
//        fetchSeasons()
    }

    // MARK: Config

    private func setupCollectionView() {
        collectionView.backgroundColor = .gthBackgroundColor
        collectionView.register(ScheduleCollectionViewCell.self, forCellWithReuseIdentifier: "ScheduleCollectionViewCell")
        collectionView.register(ScheduleCollectionViewSectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "ScheduleCollectionViewSectionHeader")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchSchedule), for: .valueChanged)
    }
    
    @objc private func fetchSchedule() {
        ContentManager().getSchedule(with: 8) { response in
            self.completedGameArray = []
            self.upcomingGameArray = []

            var wins = 0
            var losses = 0
            var otLosses = 0
            var ties = 0

            for game in response {
                if game.isReported {
                    self.completedGameArray.append(game)
                    switch game.shortResult {
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
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
                
                if self.upcomingGameArray.count > 0 {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: false)
                } else {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            }
        }
    }

//    @objc private func fetchSeasons() {
//        ContentManager().getSeasons() { response in
//            self.seasonArray = response.sorted { $0.year < $1.year }
//
//            DispatchQueue.main.async {
//                self.menuView = BTNavigationDropdownMenu(navigationController: self.navigationController,
//                                                         containerView: self.navigationController!.view,
//                                                         title: self.seasonArray[self.seasonArray.count - 1].name,
//                                                         items: self.seasonArray.map { $0.name })
//
//                self.menuView?.cellHeight = 52.0
//                self.menuView?.cellSelectionColor = .techGold
//                self.menuView?.shouldKeepSelectedCellColor = true
//                self.menuView?.cellBackgroundColor = .techNavy
//                self.menuView?.cellTextLabelColor = .white
//                self.menuView?.selectedCellTextLabelColor = .techNavy
//                self.menuView?.cellTextLabelFont = UIFont(name: "HelveticaNeue-Light", size: 16.0)
//                self.menuView?.arrowPadding = 15.0
//                self.menuView?.animationDuration = 0.5
//                if #available(iOS 13.0, *) {
//                    self.menuView?.arrowTintColor = .label
//                } else {
//                    self.menuView?.arrowTintColor = .black
//                }
//
//                self.menuView?.didSelectItemAtIndexHandler = { [weak self] (indexPath: Int) -> () in
//                    self?.currentSeasonIDSelected = self?.seasonArray[indexPath].id ?? 3
//                    self?.fetchSchedule()
//                }
//                self.navigationItem.titleView = self.menuView
//            }
//        }
//    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if completedGameArray.count == 0 || upcomingGameArray.count == 0 {
            return 1
        }
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleCollectionViewCell", for: indexPath) as! ScheduleCollectionViewCell
        
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ScheduleCollectionViewSectionHeader", for: indexPath) as! ScheduleCollectionViewSectionHeader
        switch indexPath.section {
        case 0:
            header.set(with: "Completed", seasonRecord)
        default:
            header.set(with: "Upcoming")
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 64.0)
    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width - 48.0
        return CGSize(width: cellWidth, height: cellWidth * 0.35)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }

}
