//
//  GTHCardPlusCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/31/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GTHCardPlusCollectionViewCell: GTHCardCollectionViewCell {
    
    // MARK: Properties
    
    public var shadowView = UIView()
    
    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        imageView.backgroundColor = .gray
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = false
//        imageView.layer.cornerRadius = 14.0
//        imageView.layer.masksToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        shadowView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0.0, y: 16.0, blur: 16.0, spread: 0.0)
//        shadowView.translatesAutoresizingMaskIntoConstraints = false
//        
//        shadowView.addSubview(imageView)
        
//        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()

        contentView.layoutSubviews()
    }

//    override func updateConstraints() {
//        super.updateConstraints()
//        
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
//        ])
//    }
    
}
