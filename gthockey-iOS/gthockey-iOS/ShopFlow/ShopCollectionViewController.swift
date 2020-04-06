//
//  ShopCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/31/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

// MARK: Under Construction

class ShopCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private var apparelArray: [Apparel] = []
    private var shoppingCart: [[String : Any]] = []
    private let cellWidth = UIScreen.main.bounds.width * 0.9
    private let cellHeight = UIScreen.main.bounds.height * 0.3
    private var shopDetailViewController = ShopDetailViewController()
    public var delegate: HomeControllerDelegate?

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Shop"

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
        fetchApparel()
    }

    private func setupCollectionView() {
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "ShopCollectionViewCell")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchApparel), for: .valueChanged)
    }

    @objc private func fetchApparel() {
       ContentManager().getShopItems() { response in
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
        cell.delegate = self
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.fetchApparelDetails(with: self.apparelArray[indexPath.row].getID(), completion: { (apparelRestrictedItems, apparelCustomItems) in
            self.shopDetailViewController = ShopDetailViewController()
            self.shopDetailViewController.set(with: self.apparelArray[indexPath.row], apparelRestrictedItems, apparelCustomItems)
        })
    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

    @objc private func cartButtonTapped() {
        let cartTableViewController = CartTableViewController()
        present(cartTableViewController, animated: true, completion: nil)
    }

    private func fetchApparelDetails(with id: Int, completion: @escaping ([ApparelRestrictedItem], [ApparelCustomItem]) -> Void) {
        ContentManager().getApparel(with: id) { (apparelRestrictedItems, apparelCustomItems) in
            completion(apparelRestrictedItems, apparelCustomItems)
        }
    }

}

extension ShopCollectionViewController: ShopCollectionViewCellDelegate {

    func didEndCellAnimation() {
        present(shopDetailViewController, animated: true, completion: nil)
    }

}
