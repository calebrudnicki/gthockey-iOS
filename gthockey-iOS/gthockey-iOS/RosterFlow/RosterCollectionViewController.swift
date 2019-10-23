//
//  RosterCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class RosterCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "cell"
    private let headerIdentifier = "header"
    private var forwardArray: [Player] = []
    private var defenseArray: [Player] = []
    private var goalieArray: [Player] = []
    private var managerArray: [Player] = []
    private let cellWidth = UIScreen.main.bounds.width * 0.45

    var delegate: HomeControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Roster"

        let menuButtonImage: UIImage?
        if traitCollection.userInterfaceStyle == .light {
            menuButtonImage = UIImage(named: "MenuIconBlack")?.withRenderingMode(.alwaysOriginal)
        } else {
            menuButtonImage = UIImage(named: "MenuIconWhite")?.withRenderingMode(.alwaysOriginal)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(menuButtonTapped))
        navigationController?.navigationBar.prefersLargeTitles = true

        setupCollectionView()
        fetchRoster()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return forwardArray.count
        case 1:
            return defenseArray.count
        case 2:
            return goalieArray.count
        default:
            return managerArray.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RosterCollectionViewCell

        switch indexPath.section {
        case 0:
            cell.set(with: forwardArray[indexPath.row])
        case 1:
            cell.set(with: defenseArray[indexPath.row])
        case 2:
            cell.set(with: goalieArray[indexPath.row])
        default:
            cell.set(with: managerArray[indexPath.row])
        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! RosterCollectionViewHeader
        switch indexPath.section {
        case 0:
            header.set(with: "Forwards")
        case 1:
            header.set(with: "Defense")
        case 2:
            header.set(with: "Goalies")
        default:
            header.set(with: "Managers")
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: cellWidth / 3)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rosterDetailViewController = RosterDetailViewController()
        switch indexPath.section {
        case 0:
            rosterDetailViewController.set(with: forwardArray[indexPath.row])
        case 1:
            rosterDetailViewController.set(with: defenseArray[indexPath.row])
        case 2:
            rosterDetailViewController.set(with: goalieArray[indexPath.row])
        default:
            rosterDetailViewController.set(with: managerArray[indexPath.row])
        }
        present(rosterDetailViewController, animated: true, completion: nil)
    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
    }

}

// MARK: - Private Methods

private extension RosterCollectionViewController {

    private func setupCollectionView() {
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }

        collectionView.register(RosterCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(RosterCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchRoster), for: .valueChanged)
    }

    @objc private func fetchRoster() {
        let parser = JSONParser()       
        parser.getRoster() { response in
            self.forwardArray = []
            self.defenseArray = []
            self.goalieArray = []
            self.managerArray = []

            for player in response {
                switch player.getPosition() {
                case "F":
                    self.forwardArray.append(player)
                case "D":
                    self.defenseArray.append(player)
                case "G":
                    self.goalieArray.append(player)
                default:
                    self.managerArray.append(player)
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }

}
