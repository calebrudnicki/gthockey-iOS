//
//  NewsCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class NewsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties
    
    private var animator: Animator?
    public var selectedCell: NewsCollectionViewCell?
    private var selectedCellImageViewSnapshot: UIView?
    private var newsArray: [News] = []
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchArticles()
    }
    
    // MARK: Config
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .gthBackgroundColor
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCollectionViewCell")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchArticles), for: .valueChanged)
    }
    
    @objc private func fetchArticles() {
        ContentManager().getArticles() { response in
            self.newsArray = response
            
            for i in 0..<self.newsArray.count {
                self.newsArray[i].setPreviousArticle(to: self.newsArray[i != 0 ? i - 1 : self.newsArray.count - 1])
                self.newsArray[i].setNextArticle(to: self.newsArray[i != self.newsArray.count - 1 ? i + 1 : 0])
            }
            
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
        selectedCell = collectionView.cellForItem(at: indexPath) as? NewsCollectionViewCell
        selectedCellImageViewSnapshot = selectedCell?.imageView.snapshotView(afterScreenUpdates: false)
        presentDetailViewController(for: indexPath, with: NewsCellData(image: (selectedCell?.imageView.image)!,
                                                                       date: (selectedCell?.dateLabel.text)!,
                                                                       title: (selectedCell?.titleLabel.text)!))
    }
    
    // MARK: UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width - 48.0
        return CGSize(width: cellWidth, height: cellWidth * 0.675)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }
    
    // MARK: Private Functions
    
    private func presentDetailViewController(for indexPath: IndexPath, with data: NewsCellData) {
        let newsDetailViewController = NewsDetailViewController()
        newsDetailViewController.transitioningDelegate = self
        newsDetailViewController.modalPresentationStyle = .overFullScreen
        newsDetailViewController.modalPresentationCapturesStatusBarAppearance = true
        newsDetailViewController.data = data
        newsDetailViewController.set(with: newsArray[indexPath.row])
        present(newsDetailViewController, animated: true)
    }
    
}

extension NewsCollectionViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let tabBarController = presenting as? GTHTabBarController,
            let navigationController = tabBarController.selectedViewController as? GTHNavigationController,
            let firstViewController = navigationController.topViewController as? NewsCollectionViewController,
            let secondViewController = presented as? NewsDetailViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }
        
        return Animator(type: .present,
                        firstViewController: firstViewController,
                        secondViewController: secondViewController,
                        selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let secondViewController = dismissed as? NewsDetailViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }
        
        return Animator(type: .dismiss,
                        firstViewController: self,
                        secondViewController: secondViewController,
                        selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
    }
    
}