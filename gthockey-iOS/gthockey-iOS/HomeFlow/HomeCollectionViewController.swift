//
//  HomeCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private var newsArray: [News] = []
    private let cellWidth = UIScreen.main.bounds.width * 0.9
    private let cellHeight = UIScreen.main.bounds.height * 0.45
    public var delegate: HomeControllerDelegate?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Home"

        let menuButtonImage: UIImage?
        let cartButtonImage: UIImage?

        if traitCollection.userInterfaceStyle == .dark {
            collectionView.backgroundColor = .black
            menuButtonImage = UIImage(named: "MenuIconWhite")?.withRenderingMode(.alwaysOriginal)
            cartButtonImage = UIImage(named: "CartIconWhite")?.withRenderingMode(.alwaysOriginal)
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
        fetchArticles()
    }

    // MARK: Config

    private func setupCollectionView() {
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
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

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.set(with: newsArray[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let homeDetailViewController = HomeDetailViewController()
        homeDetailViewController.set(with: newsArray[indexPath.row])
        present(homeDetailViewController, animated: true, completion: nil)
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
        delegate?.handleMenuToggle(forMenuOption: nil)
    }

    @objc private func cartButtonTapped() {
        let cartTableViewController = CartTableViewController()
        present(cartTableViewController, animated: true, completion: nil)
    }

}
