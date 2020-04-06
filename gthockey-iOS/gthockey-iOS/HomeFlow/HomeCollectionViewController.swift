//
//  HomeCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

// MARK: Under Construction

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private var newsArray: [News] = []
    private let cellWidth = UIScreen.main.bounds.width * 0.9
    private let cellHeight = UIScreen.main.bounds.height * 0.45
    private var homeDetailViewController = HomeDetailViewController()
    public var delegate: HomeControllerDelegate?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Home"

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
        // MARK: Uncomment for cart
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: cartButtonImage,
//                                                           style: .plain,
//                                                           target: self,
//                                                           action: #selector(cartButtonTapped))
        navigationController?.navigationBar.prefersLargeTitles = true

        setupCollectionView()
        fetchArticles()
    }

    // MARK: Config

    private func setupCollectionView() {
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.set(with: newsArray[indexPath.row])
        cell.delegate = self
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeDetailViewController = HomeDetailViewController()
        homeDetailViewController.set(with: newsArray[indexPath.row])
    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
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

extension HomeCollectionViewController: HomeCollectionViewCellDelegate {
    
    func didEndCellAnimation() {
        present(homeDetailViewController, animated: true, completion: nil)
    }

}
