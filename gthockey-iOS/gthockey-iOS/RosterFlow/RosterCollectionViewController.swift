//
//  RosterCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class RosterCollectionViewController: GTHCollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private var forwardArray: [Player] = []
    private var defenseArray: [Player] = []
    private var goalieArray: [Player] = []
    private var managerArray: [Player] = []
//    private let cellWidth = UIScreen.main.bounds.width * 0.45
//    private var rosterDetailViewController = RosterDetailViewController()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
//        fetchRoster()
    }

    // MARK: Config

    private func setupCollectionView() {
        collectionView.backgroundColor = .gthBackgroundColor
        collectionView.register(RosterCollectionViewCell.self, forCellWithReuseIdentifier: "RosterCollectionViewCell")
        collectionView.register(RosterCollectionViewSectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "RosterCollectionViewSectionHeader")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
    }

    @objc private func refreshCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RosterCollectionViewSectionHeader", for: indexPath) as! RosterCollectionViewSectionHeader
        header.delegate = self
        
        switch indexPath.section {
        case 0:
            header.set(with: .Forward)
        case 1:
            header.set(with: .Defense)
        case 2:
            header.set(with: .Goalie)
        case 3:
            header.set(with: .Manager)
        default: break
        }
        
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 232.0)
    }
    
    // MARK: Private Functions
    
    private func presentDetailViewController(with data: GTHCellData, for player: Player) {
        if player.position == .Manager {
            let managerDetailViewController = ManagerDetailViewController()
            managerDetailViewController.transitioningDelegate = self
            managerDetailViewController.modalPresentationStyle = .overFullScreen
            managerDetailViewController.modalPresentationCapturesStatusBarAppearance = true
            managerDetailViewController.data = data
            managerDetailViewController.set(with: player.imageURL,
                                           player.lastName,
                                           player.position,
                                           player.hometown,
                                           player.school,
                                           player.bio)
            present(managerDetailViewController, animated: true)
        } else {
            let rosterDetailViewController = RosterDetailViewController()
            rosterDetailViewController.transitioningDelegate = self
            rosterDetailViewController.modalPresentationStyle = .overFullScreen
            rosterDetailViewController.modalPresentationCapturesStatusBarAppearance = true
            rosterDetailViewController.data = data
            rosterDetailViewController.set(with: player.imageURL,
                                           player.firstName,
                                           player.position,
                                           player.hometown,
                                           player.school,
                                           player.bio)
            present(rosterDetailViewController, animated: true)
        }
    }

}

extension RosterCollectionViewController: RosterCollectionViewSectionHeaderDelegate {
    
    func didSelectItem(cell: GTHCardCollectionViewCell, for player: Player) {
        selectedCell = cell
        selectedCellImageViewSnapshot = cell.imageView.snapshotView(afterScreenUpdates: false)
        presentDetailViewController(with: GTHCellData(image: (selectedCell?.imageView.image)!,
                                                      primaryLabel: (selectedCell?.primaryLabel.text)!,
                                                      secondaryLabel: (selectedCell?.secondaryLabel.text)!),
                                    for: player)
    }
    
}
