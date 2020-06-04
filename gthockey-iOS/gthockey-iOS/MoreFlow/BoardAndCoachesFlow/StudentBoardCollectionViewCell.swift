//
//  StudentBoardCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/30/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class StudentBoardCollectionViewCell: GTHCardPlusCollectionViewCell {
    
    // MARK: Properties
        
    private let descriptionTextView: HTMLTextView = {
        let descriptionTextView = HTMLTextView()
        descriptionTextView.font = UIFont.DINAlternate.bold.font(size: 16.0)
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
        return descriptionTextView
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        imageView.layer.cornerRadius = 14.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        shadowView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0.0, y: 16.0, blur: 16.0, spread: 0.0)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        primaryLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        primaryLabel.numberOfLines = 1
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        secondaryLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        secondaryLabel.textColor = UIColor.boardMemberCellNameColor
        secondaryLabel.numberOfLines = 1
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layer.masksToBounds = false

        shadowView.addSubview(imageView)
        contentView.addSubviews([primaryLabel, shadowView, secondaryLabel, descriptionTextView])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            primaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            primaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 4.0),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: 120.0),
            shadowView.widthAnchor.constraint(equalToConstant: 120.0)
        ])
        
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(equalTo: shadowView.topAnchor),
            secondaryLabel.leadingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 8.0),
            secondaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 8.0),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: shadowView.bottomAnchor)
        ])
    }
    
    // MARK: Setter
    
    public func set(with boardMember: BoardMember) {
        imageView.sd_setImage(with: boardMember.imageURL, placeholderImage: nil)
        primaryLabel.text = boardMember.position
        secondaryLabel.text = "\(boardMember.firstName) \(boardMember.lastName)"
        descriptionTextView.text = boardMember.description        
    }

}
