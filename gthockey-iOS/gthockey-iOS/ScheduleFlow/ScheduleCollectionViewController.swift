//
//  ScheduleCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ScheduleCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "cell"
    private var gameArray: [Game] = []
    private let cellWidth = UIScreen.main.bounds.width * 0.9
    private let cellHeight = UIScreen.main.bounds.height * 0.1

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Schedule"
        navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.backgroundColor = .white

        self.collectionView!.register(ScheduleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let parser = JSONParser()
        parser.getSchedule() { response in
            self.gameArray = response
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameArray.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScheduleCollectionViewCell
        cell.set(with: gameArray[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }

}
