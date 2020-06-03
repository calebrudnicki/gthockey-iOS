//
//  StudentBoardCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/30/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class StudentBoardCollectionViewCell: GTHCardPlusCollectionViewCell {
    
    private var isLeftSet: Bool = true
    
    private let descriptionTextView = HTMLTextView(frame: .zero)

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
        secondaryLabel.textColor = .black
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
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
        ])
        
        if isLeftSet {
            NSLayoutConstraint.activate([
                shadowView.topAnchor.constraint(equalTo: contentView.topAnchor),
                shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                shadowView.heightAnchor.constraint(equalToConstant: 120.0),
                shadowView.widthAnchor.constraint(equalToConstant: 120.0)
            ])
            
            NSLayoutConstraint.activate([
                primaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                primaryLabel.leadingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 8.0),
                primaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
            
            NSLayoutConstraint.activate([
                secondaryLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 8.0),
                secondaryLabel.leadingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 8.0),
                secondaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
            
            NSLayoutConstraint.activate([
                descriptionTextView.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: 8.0),
                descriptionTextView.leadingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 8.0),
                descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                descriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                shadowView.topAnchor.constraint(equalTo: contentView.topAnchor),
                shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                shadowView.heightAnchor.constraint(equalToConstant: 120.0),
                shadowView.widthAnchor.constraint(equalToConstant: 120.0)
            ])
            
            NSLayoutConstraint.activate([
                primaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                primaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                primaryLabel.trailingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: -8.0)
            ])
            
            NSLayoutConstraint.activate([
                secondaryLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 8.0),
                secondaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                secondaryLabel.trailingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: -8.0)
            ])
            
            NSLayoutConstraint.activate([
                descriptionTextView.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: 8.0),
                descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                descriptionTextView.trailingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: -8.0),
                descriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
            ])
        }

//        NSLayoutConstraint.activate([
//            descriptionTextView.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: 0.0),
//            descriptionTextView.leadingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 12.0),
//            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
    }
    
    // MARK: Setter
    
    public func set(with boardMember: BoardMember, leftSet: Bool) {
        imageView.sd_setImage(with: boardMember.imageURL, placeholderImage: nil)
        primaryLabel.text = boardMember.position
        secondaryLabel.text = "\(boardMember.firstName) \(boardMember.lastName)"
        descriptionTextView.text = boardMember.description
        
        isLeftSet = leftSet
        primaryLabel.textAlignment = isLeftSet ? .left : .right
        secondaryLabel.textAlignment = isLeftSet ? .left : .right
        descriptionTextView.textAlignment = isLeftSet ? .left : .right
        
        updateConstraints()
    }

}
