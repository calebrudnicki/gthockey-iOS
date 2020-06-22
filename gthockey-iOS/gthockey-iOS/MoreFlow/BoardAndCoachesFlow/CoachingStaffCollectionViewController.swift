//
//  CoachingStaffCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/30/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class CoachingStaffCollectionViewController: GTHCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    
    private var coachArray: [Coach] = []
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchCoaches()
    }
    
    // MARK: Config
    
    private func setupCollectionView() {
        collectionView.register(CoachingStaffCollectionViewCell.self, forCellWithReuseIdentifier: "CoachingStaffCollectionViewCell")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchCoaches), for: .valueChanged)
    }
    
    @objc private func fetchCoaches() {
        ContentManager().getCoaches() { response in
            self.coachArray = response
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coachArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoachingStaffCollectionViewCell", for: indexPath) as! CoachingStaffCollectionViewCell
        cell.set(with: coachArray[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath) as? GTHCardCollectionViewCell
        selectedCellImageViewSnapshot = selectedCell?.imageView.snapshotView(afterScreenUpdates: false)
        presentDetailViewController(for: indexPath, with: GTHCellData(image: (selectedCell?.imageView.image)!,
                                                                      primaryLabel: (selectedCell?.primaryLabel.text)!,
                                                                      secondaryLabel: (selectedCell?.secondaryLabel.text)!))
    }
    
    // MARK: UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width - (systemMinimumLayoutMargins.leading * 2)
        return CGSize(width: cellWidth, height: 152.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return systemMinimumLayoutMargins.leading
    }
    
    // MARK: Private Functions
    
    private func presentDetailViewController(for indexPath: IndexPath, with data: GTHCellData) {
        let coachingStaffDetailViewController = CoachingStaffDetailViewController()
        coachingStaffDetailViewController.transitioningDelegate = self
        coachingStaffDetailViewController.modalPresentationStyle = .overFullScreen
        coachingStaffDetailViewController.modalPresentationCapturesStatusBarAppearance = true
        coachingStaffDetailViewController.data = data
        coachingStaffDetailViewController.set(with: coachArray[indexPath.row])
        present(coachingStaffDetailViewController, animated: true)
    }

}
