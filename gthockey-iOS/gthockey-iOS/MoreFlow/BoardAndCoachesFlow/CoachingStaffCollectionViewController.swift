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
    
    // MARK: UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width - 48.0
        return CGSize(width: cellWidth, height: 152.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }
    
    // MARK: Private Functions
    
//    private func presentDetailViewController(for indexPath: IndexPath, with data: GTHCellData) {
//        let newsDetailViewController = NewsDetailViewController()
//        newsDetailViewController.transitioningDelegate = self
//        newsDetailViewController.modalPresentationStyle = .overFullScreen
//        newsDetailViewController.modalPresentationCapturesStatusBarAppearance = true
//        newsDetailViewController.data = data
//        newsDetailViewController.set(with: newsArray[indexPath.row])
//        present(newsDetailViewController, animated: true)
//    }

}
