//
//  ShopCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/31/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ShopCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private var apparelArray: [Apparel] = []
    private let cellWidth = UIScreen.main.bounds.width * 0.9
    private let cellHeight = UIScreen.main.bounds.height * 0.3
    public var delegate: HomeControllerDelegate?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Shop"

        let menuButtonImage: UIImage?
        if traitCollection.userInterfaceStyle == .dark {
            collectionView.backgroundColor = .black
            menuButtonImage = UIImage(named: "MenuIconWhite")?.withRenderingMode(.alwaysOriginal)
        } else {
            collectionView.backgroundColor = .white
            menuButtonImage = UIImage(named: "MenuIconBlack")?.withRenderingMode(.alwaysOriginal)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(menuButtonTapped))
        navigationController?.navigationBar.prefersLargeTitles = true

        setupCollectionView()
        fetchApparel()
    }

    private func setupCollectionView() {
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "ShopCollectionViewCell")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchApparel), for: .valueChanged)
    }

    @objc private func fetchApparel() {
       let parser = JSONParser()
       parser.getApparel() { response in
           self.apparelArray = []
           self.apparelArray = response
           DispatchQueue.main.async {
               self.collectionView.reloadData()
               self.collectionView.refreshControl?.endRefreshing()
           }
       }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apparelArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
        cell.set(with: apparelArray[indexPath.row])
        return cell
    }

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let homeDetailViewController = HomeDetailViewController()
//        homeDetailViewController.set(with: apparelArray[indexPath.row])
//        present(homeDetailViewController, animated: true, completion: nil)
//    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 24.0
//    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }

}
