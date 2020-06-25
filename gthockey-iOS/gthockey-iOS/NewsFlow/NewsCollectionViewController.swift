//
//  NewsCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class NewsCollectionViewController: GTHCollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private var newsArray: [News] = []
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchArticles()
    }
    
    // MARK: Config
    
    private func setupCollectionView() {
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCollectionViewCell")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchArticles), for: .valueChanged)
    }
    
    @objc private func fetchArticles() {
        ContentManager().getArticles() { response in
            self.newsArray = response
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        cell.set(with: newsArray[indexPath.row])
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
        return CGSize(width: cellWidth, height: cellWidth * 0.675)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return systemMinimumLayoutMargins.leading
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return systemMinimumLayoutMargins.leading
    }
    
    // MARK: Private Functions
    
    private func presentDetailViewController(for indexPath: IndexPath, with data: GTHCellData) {
        let newsDetailViewController = NewsDetailViewController()
        newsDetailViewController.transitioningDelegate = self
        newsDetailViewController.modalPresentationStyle = .overFullScreen
        newsDetailViewController.modalPresentationCapturesStatusBarAppearance = true
        newsDetailViewController.data = data
        newsDetailViewController.set(with: newsArray[indexPath.row])
        present(newsDetailViewController, animated: true)
    }
    
}
