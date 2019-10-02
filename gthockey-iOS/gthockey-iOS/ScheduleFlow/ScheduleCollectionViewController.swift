//
//  ScheduleCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ScheduleCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "cell"
    private var gameArray: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Schedule"
        navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.backgroundColor = .white

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let parser = JSONParser()
        parser.getSchedule() { response in
            self.gameArray = response
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView,
								 shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

	/*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to
	// actions performed on the item
    override func collectionView(_ collectionView: UICollectionView,
								 shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView,
								 canPerformAction action: Selector,
								 forItemAt indexPath: IndexPath,
								 withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView,
								 performAction action: Selector,
								 forItemAt indexPath: IndexPath,
								 withSender sender: Any?) {
    
    }
    */

}
