//
//  HomeCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "cell"
    private var newsArray: [News] = []
    private let cellWidth = UIScreen.main.bounds.width * 0.9
    private let cellHeight = UIScreen.main.bounds.height * 0.45

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupCollectionView()
        fetchArticles()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.set(with: newsArray[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let homeDetailsViewController = HomeDetailViewController()
        homeDetailsViewController.setArticle(with: newsArray[indexPath.row])
        present(homeDetailsViewController, animated: true, completion: nil)
    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }

}

// MARK: - Private Methods

private extension HomeCollectionViewController {

    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchArticles), for: .valueChanged)
    }

    @objc private func fetchArticles() {
        let parser = JSONParser()
        parser.getArticles() { response in
            self.newsArray = []
            self.newsArray = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }

}
