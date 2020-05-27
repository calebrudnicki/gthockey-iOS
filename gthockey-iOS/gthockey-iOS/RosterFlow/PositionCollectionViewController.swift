//
//  PositionCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class PositionCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: Properties

    private var forwardArray: [Player] = []

    // MARK: Init
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupCollectionView()
        fetchRoster()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Config

    private func setupCollectionView() {
        delegate = self
        dataSource = self
        register(RosterCollectionViewCell.self, forCellWithReuseIdentifier: "RosterCollectionViewCell")
    }

    @objc private func fetchRoster() {
        ContentManager().getRoster() { response in
            self.forwardArray = []

            for player in response {
                if player.position == .Forward {
                    self.forwardArray.append(player)
                }
            }
            
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forwardArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RosterCollectionViewCell", for: indexPath) as! RosterCollectionViewCell
        cell.set(with: forwardArray[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewLayout

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 128.0, height: 169.0)
//    }

}
