//
//  GTHCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/26/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GTHCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    
    private var animator: Animator?
    public var selectedCell: GTHCardCollectionViewCell?
    public var selectedCellImageViewSnapshot: UIView?
    
    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .gthBackgroundColor
    }

}

extension GTHCollectionViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let gthTabBarController = presenting as? GTHTabBarController,
            let gthNavigationController = gthTabBarController.selectedViewController as? GTHNavigationController,
            let gthCollectionViewController = gthNavigationController.topViewController as? GTHCollectionViewController,
            let gthDetailViewController = presented as? GTHDetailViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }

        return Animator(type: .present,
                        fromViewController: gthCollectionViewController,
                        toViewController: gthDetailViewController,
                        selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let gthDetailViewController = dismissed as? GTHDetailViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }

        return Animator(type: .dismiss,
                        fromViewController: self,
                        toViewController: gthDetailViewController,
                        selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
    }

}

