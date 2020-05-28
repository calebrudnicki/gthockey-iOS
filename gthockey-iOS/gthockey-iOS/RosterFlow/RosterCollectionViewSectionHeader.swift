//
//  RosterCollectionViewSectionHeader.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class RosterCollectionViewSectionHeader: UICollectionReusableView {
        
    // MARK: Properties

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.DINCondensed.bold.font(size: 32.0)
        titleLabel.textColor = UIColor.rosterHeaderTitleColor
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let positionCollectionView: PositionCollectionView = {
        let rosterLayout = UICollectionViewFlowLayout()
        rosterLayout.scrollDirection = .horizontal
//        rosterLayout.minimumInteritemSpacing = 24.0
        rosterLayout.itemSize = CGSize(width: 128.0, height: 128.0)
        rosterLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 0.0)
        let positionCollectionView = PositionCollectionView(frame: .zero, collectionViewLayout: rosterLayout)
        positionCollectionView.backgroundColor = .red
        positionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return positionCollectionView
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews([titleLabel, positionCollectionView])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
        ])
        
        NSLayoutConstraint.activate([
            positionCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0),
            positionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            positionCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            positionCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Setter

    public func set(with position: Position) {
        titleLabel.text = position.description
    }
    
}
