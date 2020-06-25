//
//  StudentBoardCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/30/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class StudentBoardCollectionViewController: GTHCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    
    private var boardMemberArray: [BoardMember] = []
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setupCollectionView()
        fetchBoardMembers()
    }
    
    // MARK: Config
    
    private func setupCollectionView() {
        collectionView.register(StudentBoardCollectionViewCell.self, forCellWithReuseIdentifier: "StudentBoardCollectionViewCell")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchBoardMembers), for: .valueChanged)
    }
    
    @objc private func fetchBoardMembers() {
        ContentManager().getBoardMembers() { response in
            self.boardMemberArray = response
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardMemberArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentBoardCollectionViewCell", for: indexPath) as! StudentBoardCollectionViewCell
        cell.set(with: boardMemberArray[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath) as? GTHCardCollectionViewCell
        selectedCellImageViewSnapshot = selectedCell?.imageView.snapshotView(afterScreenUpdates: false)
        presentDetailViewController(for: indexPath, with: GTHCellData(image: (selectedCell?.imageView.image)!,
                                                                      primaryLabel: (selectedCell?.primaryLabel.text)!,
                                                                      secondaryLabel: (selectedCell?.secondaryLabel.text)!))
    }
    
    // MARK: UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width - (systemMinimumLayoutMargins.leading * 2)
        return CGSize(width: cellWidth, height: 152.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return systemMinimumLayoutMargins.leading
    }
    
    // MARK: Private Functions
    
    private func presentDetailViewController(for indexPath: IndexPath, with data: GTHCellData) {
        let studentBoardDetailViewController = StudentBoardDetailViewController()
        studentBoardDetailViewController.transitioningDelegate = self
        studentBoardDetailViewController.modalPresentationStyle = .overFullScreen
        studentBoardDetailViewController.modalPresentationCapturesStatusBarAppearance = true
        studentBoardDetailViewController.data = data
        studentBoardDetailViewController.set(with: boardMemberArray[indexPath.row])
        present(studentBoardDetailViewController, animated: true)
    }

}
