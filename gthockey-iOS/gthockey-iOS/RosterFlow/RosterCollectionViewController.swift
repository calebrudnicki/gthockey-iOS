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
    private let cellWidth = UIScreen.main.bounds.width * 0.45
    private var rosterDetailViewController = RosterDetailViewController()
    public var delegate: HomeControllerDelegate?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Roster"

        let menuButtonImage: UIImage?
        let cartButtonImage: UIImage?

        if #available(iOS 13.0, *){
            collectionView.backgroundColor = .systemBackground
            menuButtonImage = UIImage(systemName: "line.horizontal.3")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
            cartButtonImage = UIImage(systemName: "cart.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        } else {
            collectionView.backgroundColor = .white
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

        setupCollectionView()
        fetchRoster()
    }

    // MARK: Config

    private func setupCollectionView() {
        collectionView.register(RosterCollectionViewCell.self, forCellWithReuseIdentifier: "RosterCollectionViewCell")
        collectionView.register(RosterCollectionViewHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "RosterCollectionViewHeader")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RosterCollectionViewCell", for: indexPath) as! RosterCollectionViewCell

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

        cell.delegate = self
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RosterCollectionViewHeader", for: indexPath) as! RosterCollectionViewHeader
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
        rosterDetailViewController = RosterDetailViewController()
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
    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

    @objc private func cartButtonTapped() {
        let cartTableViewController = CartTableViewController()
        present(cartTableViewController, animated: true, completion: nil)
    }

}

extension RosterCollectionViewController: RosterCollectionViewCellDelegate {

    func didEndCellAnimation() {
        present(rosterDetailViewController, animated: true, completion: nil)
    }

}
