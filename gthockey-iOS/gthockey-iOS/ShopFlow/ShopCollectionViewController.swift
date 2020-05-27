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

    private var animator: Animator?
//    public var selectedCell: NewsCollectionViewCell?
    private var selectedCellImageViewSnapshot: UIView?
    private var apparelArray: [Apparel] = []

    private var shoppingCart: [[String : Any]] = []
//    private var shopDetailViewController = ShopDetailViewController()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        fetchApparel()
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .gthBackgroundColor
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
        self.fetchApparelDetails(with: self.apparelArray[indexPath.row].getID(), completion: { (apparelRestrictedItems, apparelCustomItems) in
            self.selectedCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
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
        let cellWidth = UIScreen.main.bounds.width - 48.0
        return CGSize(width: cellWidth, height: cellWidth * 1.03)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }

    // MARK: Private Functions

    private func presentDetailViewController(for indexPath: IndexPath, with data: GTHCellData, restrictedOptions: [ApparelRestrictedItem], customOptions: [ApparelCustomItem] ) {
        let shopDetailViewController = ShopDetailViewController()
        shopDetailViewController.transitioningDelegate = self
        shopDetailViewController.modalPresentationStyle = .overFullScreen
        shopDetailViewController.modalPresentationCapturesStatusBarAppearance = true
        shopDetailViewController.data = data
        shopDetailViewController.set(with: apparelArray[indexPath.row], restrictedOptions, customOptions)
        present(shopDetailViewController, animated: true)
    }

    // MARK: Action

    private func fetchApparelDetails(with id: Int, completion: @escaping ([ApparelRestrictedItem], [ApparelCustomItem]) -> Void) {
        ContentManager().getApparel(with: id) { (apparelRestrictedItems, apparelCustomItems) in
            completion(apparelRestrictedItems, apparelCustomItems)
        }
    }

}

extension ShopCollectionViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let tabBarController = presenting as? GTHTabBarController,
            let navigationController = tabBarController.selectedViewController as? GTHNavigationController,
            let firstViewController = navigationController.topViewController as? ShopCollectionViewController,
            let secondViewController = presented as? ShopDetailViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }

        return Animator(type: .present,
                        fromViewController: firstViewController,
                        toViewController: secondViewController,
                        selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let secondViewController = dismissed as? ShopDetailViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }

        return Animator(type: .dismiss,
                        fromViewController: self,
                        toViewController: secondViewController,
                        selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
    }

}
