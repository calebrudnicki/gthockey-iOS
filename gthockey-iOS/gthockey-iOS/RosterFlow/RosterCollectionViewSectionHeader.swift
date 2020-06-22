//
//  RosterCollectionViewSectionHeader.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol RosterCollectionViewSectionHeaderDelegate {
    func didSelectItem(cell: GTHCardCollectionViewCell, for player: Player)
}

class RosterCollectionViewSectionHeader: UICollectionReusableView {
        
    // MARK: Properties
    
    public var leadingLayoutMargin: CGFloat = 24.0
    
    public var delegate: RosterCollectionViewSectionHeaderDelegate?

    private var playerArray: [Player] = []

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.DINCondensed.bold.font(size: 32.0)
        titleLabel.textColor = UIColor.rosterHeaderTitleColor
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let positionCollectionView: UICollectionView = {
        let rosterLayout = UICollectionViewFlowLayout()
        rosterLayout.scrollDirection = .horizontal
        rosterLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        let positionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: rosterLayout)
        positionCollectionView.showsHorizontalScrollIndicator = false
        positionCollectionView.backgroundColor = UIColor.gthBackgroundColor
        positionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return positionCollectionView
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()

        addSubviews([titleLabel, positionCollectionView])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: leadingLayoutMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingLayoutMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leadingLayoutMargin),
        ])
        
        NSLayoutConstraint.activate([
            positionCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            positionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            positionCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            positionCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Setter

    public func set(with position: Position) {
        titleLabel.text = position.description
        fetchRoster(for: position)
    }
    
}

extension RosterCollectionViewSectionHeader: UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: Config

    private func setupCollectionView() {
        positionCollectionView.delegate = self
        positionCollectionView.dataSource = self
        positionCollectionView.register(RosterCollectionViewCell.self, forCellWithReuseIdentifier: "RosterCollectionViewCell")
    }

    private func fetchRoster(for position: Position) {
        ContentManager().getRoster() { response in
            self.playerArray = []

            for player in response {
                if player.position == position {
                    self.playerArray.append(player)
                }
            }
            
            DispatchQueue.main.async {
                self.positionCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RosterCollectionViewCell", for: indexPath) as! RosterCollectionViewCell
        cell.set(with: playerArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(cell: collectionView.cellForItem(at: indexPath) as! GTHCardCollectionViewCell, for: playerArray[indexPath.row])
    }
    
}

extension RosterCollectionViewSectionHeader: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120.0, height: 120.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return leadingLayoutMargin
    }
    
}
