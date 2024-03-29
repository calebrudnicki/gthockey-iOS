//
//  ShopCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/31/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ShopCollectionViewController: GTHCollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties

    private var apparelArray: [Apparel] = []
    private var shoppingCart: [[String : Any]] = []

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.fetchApparelDetails(with: self.apparelArray[indexPath.row].id, completion: { (apparelRestrictedItems, apparelCustomItems) in
            self.selectedCell = collectionView.cellForItem(at: indexPath) as? GTHCardCollectionViewCell
            self.selectedCellImageViewSnapshot = self.selectedCell?.imageView.snapshotView(afterScreenUpdates: false)
            self.presentDetailViewController(for: indexPath,
                                             with: GTHCellData(image: (self.selectedCell?.imageView.image)!,
                                                               primaryLabel: (self.selectedCell?.primaryLabel.text)!,
                                                               secondaryLabel: (self.selectedCell?.secondaryLabel.text)!),
                                             restrictedOptions: apparelRestrictedItems,
                                             customOptions: apparelCustomItems)
        })
    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width - (systemMinimumLayoutMargins.leading * 2)
        return CGSize(width: cellWidth, height: cellWidth * 1.03)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return systemMinimumLayoutMargins.leading
    }
    // MARK: Private Functions

    private func presentDetailViewController(for indexPath: IndexPath, with data: GTHCellData, restrictedOptions: [ApparelRestrictedItem], customOptions: [ApparelCustomItem]) {
        let shopDetailViewController = ShopDetailViewController()
        shopDetailViewController.transitioningDelegate = self
        shopDetailViewController.modalPresentationStyle = .overFullScreen
        shopDetailViewController.modalPresentationCapturesStatusBarAppearance = true
        shopDetailViewController.data = data
        shopDetailViewController.set(with: apparelArray[indexPath.row], restrictedOptions, customOptions)
        present(shopDetailViewController, animated: true)
    }

    private func fetchApparelDetails(with id: Int, completion: @escaping ([ApparelRestrictedItem], [ApparelCustomItem]) -> Void) {
        ContentManager().getApparel(with: id) { (apparelRestrictedItems, apparelCustomItems) in
            completion(apparelRestrictedItems, apparelCustomItems)
        }
    }

}
