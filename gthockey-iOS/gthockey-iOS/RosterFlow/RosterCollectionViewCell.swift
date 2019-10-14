//
//  RosterCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/4/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class RosterCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let firstNameLabel: UILabel = {
        let firstNameLabel = UILabel()
        firstNameLabel.font = UIFont(name:"Helvetica-Neue Light", size: 12.0)
        firstNameLabel.numberOfLines = 1
        firstNameLabel.textAlignment = .center
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return firstNameLabel
    }()
    
    private let lastNameLabel: UILabel = {
        let lastNameLabel = UILabel()
        lastNameLabel.font = UIFont(name:"Helvetica Neue", size: 24.0)
        lastNameLabel.numberOfLines = 1
        lastNameLabel.textAlignment = .center
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return lastNameLabel
    }()
    
    private let numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.font = UIFont(name:"Helvetica-Neue Light", size: 20.0)
        numberLabel.numberOfLines = 1
        numberLabel.textAlignment = .left
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberLabel
    }()
    
    private let positionLabel: UILabel = {
        let positionLabel = UILabel()
        positionLabel.font = UIFont(name:"Helvetica-Neue Light", size: 20.0)
        positionLabel.numberOfLines = 1
        positionLabel.textAlignment = .right
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        return positionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(positionLabel)
        
        layoutSubviews()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4.0),
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            firstNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0)
        ])
        
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor),
            lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            lastNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0)
        ])
        
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            positionLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            positionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            positionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 13.0, *) {
            layer.backgroundColor = UIColor(named: "darkBackground")?.cgColor    
            layer.shadowColor = UIColor.label.cgColor
        } else {
            layer.backgroundColor = UIColor.white   .cgColor
            layer.shadowColor = UIColor.black.cgColor
        }
        
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 7.0
        layer.cornerRadius = 6.0
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        
        contentView.layer.cornerRadius = 6.0
        contentView.layer.masksToBounds = true
    }
    
    public func set(with player: Player) {
        imageView.sd_setImage(with: player.getImageURL(), placeholderImage: nil)
        firstNameLabel.text = player.getFirstName()
        lastNameLabel.text = player.getLastName()
        numberLabel.text = "#\(player.getNumber())"
        positionLabel.text = player.getPosition()
        
        layoutIfNeeded()
    }
    
}
