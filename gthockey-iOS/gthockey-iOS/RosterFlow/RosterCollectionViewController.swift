//
//  RosterCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class RosterCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private var forwardArray: [Player] = []
    private var defenseArray: [Player] = []
    private var goalieArray: [Player] = []
    private var managerArray: [Player] = []
//    private let cellWidth = UIScreen.main.bounds.width * 0.45
    private var rosterDetailViewController = RosterDetailViewController()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        fetchRoster()
    }

    // MARK: Config

    private func setupCollectionView() {
        collectionView.backgroundColor = .gthBackgroundColor
        collectionView.register(RosterCollectionViewCell.self, forCellWithReuseIdentifier: "RosterCollectionViewCell")
        collectionView.register(RosterCollectionViewSectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "RosterCollectionViewSectionHeader")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchRoster), for: .valueChanged)
    }

    @objc private func fetchRoster() {
        ContentManager().getRoster() { response in
            self.forwardArray = []
            self.defenseArray = []
            self.goalieArray = []
            self.managerArray = []

            for player in response {
                switch player.position {
                case .Forward:
                    self.forwardArray.append(player)
                case .Defense:
                    self.defenseArray.append(player)
                case .Goalie:
                    self.goalieArray.append(player)
                case .Manager:
                    self.managerArray.append(player)
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return forwardArray.count
//        case 1:
//            return defenseArray.count
//        case 2:
//            return goalieArray.count
//        default:
//            return managerArray.count
//        }
//    }

//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RosterCollectionViewCell", for: indexPath) as! RosterCollectionViewCell
//
//        switch indexPath.section {
//        case 0:
//            cell.set(with: forwardArray[indexPath.row])
//        case 1:
//            cell.set(with: defenseArray[indexPath.row])
//        case 2:
//            cell.set(with: goalieArray[indexPath.row])
//        default:
//            cell.set(with: managerArray[indexPath.row])
//        }
//
//        return cell
//    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RosterCollectionViewSectionHeader", for: indexPath) as! RosterCollectionViewSectionHeader
        
        switch indexPath.section {
        case 0:
            header.set(with: .Forward)
        case 1:
            header.set(with: .Defense)
        case 2:
            header.set(with: .Goalie)
        default:
            header.set(with: .Manager)
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200.0)
    }

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        rosterDetailViewController = RosterDetailViewController()
//        switch indexPath.section {
//        case 0:
//            rosterDetailViewController.set(with: forwardArray[indexPath.row])
//        case 1:
//            rosterDetailViewController.set(with: defenseArray[indexPath.row])
//        case 2:
//            rosterDetailViewController.set(with: goalieArray[indexPath.row])
//        default:
//            rosterDetailViewController.set(with: managerArray[indexPath.row])
//        }
//    }

    // MARK: UICollectionViewLayout

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: cellWidth, height: cellWidth)
//    }

}
