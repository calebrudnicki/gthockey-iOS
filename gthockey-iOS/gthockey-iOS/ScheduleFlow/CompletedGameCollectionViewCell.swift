//
//  CompletedGameCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/22/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class CompletedGameCollectionViewCell: CardCollectionViewCell {

    // MARK: Properties

    private let awayImageView: UIImageView = {
        let awayImageView = UIImageView()
        awayImageView.backgroundColor = .gray
        awayImageView.clipsToBounds = true
        awayImageView.contentMode = .scaleAspectFill
        awayImageView.translatesAutoresizingMaskIntoConstraints = false
        return awayImageView
    }()
    
    private let homeImageView: UIImageView = {
        let homeImageView = UIImageView()
        homeImageView.backgroundColor = .gray
        homeImageView.clipsToBounds = true
        homeImageView.contentMode = .scaleAspectFill
        homeImageView.translatesAutoresizingMaskIntoConstraints = false
        return homeImageView
    }()
    
    private let awaySchoolLabel: UILabel = {
        let awaySchoolLabel = UILabel()
        awaySchoolLabel.font = UIFont.DINCondensed.bold.font(size: 16.0)
        awaySchoolLabel.textColor = UIColor.scheduleCellTeamInfoColor
        awaySchoolLabel.textAlignment = .center
        awaySchoolLabel.adjustsFontSizeToFitWidth = true
        awaySchoolLabel.numberOfLines = 1
        awaySchoolLabel.translatesAutoresizingMaskIntoConstraints = false
        return awaySchoolLabel
    }()
    
    private let awayMascotLabel: UILabel = {
        let awayMascotLabel = UILabel()
        awayMascotLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        awayMascotLabel.textColor = UIColor.scheduleCellTeamInfoColor
        awayMascotLabel.textAlignment = .center
        awayMascotLabel.adjustsFontSizeToFitWidth = true
        awayMascotLabel.numberOfLines = 1
        awayMascotLabel.translatesAutoresizingMaskIntoConstraints = false
        return awayMascotLabel
    }()
    
    private let awayScoreLabel: UILabel = {
        let awayScoreLabel = UILabel()
        awayScoreLabel.font = UIFont.DINAlternate.bold.font(size: 24.0)
        awayScoreLabel.textColor = UIColor.scheduleCellTeamInfoColor
        awayScoreLabel.textAlignment = .center
        awayScoreLabel.adjustsFontSizeToFitWidth = true
        awayScoreLabel.numberOfLines = 1
        awayScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return awayScoreLabel
    }()
    
    private let awayStack: UIStackView = {
        let awayStack = UIStackView()
        awayStack.axis = .vertical
        awayStack.distribution = .fillProportionally
        awayStack.translatesAutoresizingMaskIntoConstraints = false
        return awayStack
    }()
    
    private let homeSchoolLabel: UILabel = {
        let homeSchoolLabel = UILabel()
        homeSchoolLabel.font = UIFont.DINCondensed.bold.font(size: 16.0)
        homeSchoolLabel.textColor = UIColor.scheduleCellTeamInfoColor
        homeSchoolLabel.textAlignment = .center
        homeSchoolLabel.adjustsFontSizeToFitWidth = true
        homeSchoolLabel.numberOfLines = 1
        homeSchoolLabel.translatesAutoresizingMaskIntoConstraints = false
        return homeSchoolLabel
    }()
    
    private let homeMascotLabel: UILabel = {
        let homeMascotLabel = UILabel()
        homeMascotLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        homeMascotLabel.textColor = UIColor.scheduleCellTeamInfoColor
        homeMascotLabel.textAlignment = .center
        homeMascotLabel.adjustsFontSizeToFitWidth = true
        homeMascotLabel.numberOfLines = 1
        homeMascotLabel.translatesAutoresizingMaskIntoConstraints = false
        return homeMascotLabel
    }()
    
    private let homeScoreLabel: UILabel = {
        let homeScoreLabel = UILabel()
        homeScoreLabel.font = UIFont.DINAlternate.bold.font(size: 24.0)
        homeScoreLabel.textColor = UIColor.scheduleCellTeamInfoColor
        homeScoreLabel.textAlignment = .center
        homeScoreLabel.adjustsFontSizeToFitWidth = true
        homeScoreLabel.numberOfLines = 1
        homeScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return homeScoreLabel
    }()
    
    private let homeStack: UIStackView = {
        let homeStack = UIStackView()
        homeStack.axis = .vertical
        homeStack.distribution = .fillProportionally
        homeStack.translatesAutoresizingMaskIntoConstraints = false
        return homeStack
    }()
    
    private let teamsContentStack: UIStackView = {
        let teamsContentStack = UIStackView()
        teamsContentStack.axis = .horizontal
        teamsContentStack.distribution = .fillEqually
        teamsContentStack.translatesAutoresizingMaskIntoConstraints = false
        return teamsContentStack
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.DINCondensed.bold.font(size: 14.0)
        dateLabel.textColor = UIColor.scheduleCellGameInfoColor
        dateLabel.textAlignment = .center
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.numberOfLines = 1
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private let rinkLabel: UILabel = {
        let rinkLabel = UILabel()
        rinkLabel.font = UIFont.DINCondensed.bold.font(size: 14.0)
        rinkLabel.textColor = UIColor.scheduleCellGameInfoColor
        rinkLabel.textAlignment = .center
        rinkLabel.adjustsFontSizeToFitWidth = true
        rinkLabel.numberOfLines = 1
        rinkLabel.translatesAutoresizingMaskIntoConstraints = false
        return rinkLabel
    }()
    
    private let gameContentStack: UIStackView = {
        let gameContentStack = UIStackView()
        gameContentStack.axis = .vertical
        gameContentStack.distribution = .fillEqually
        gameContentStack.translatesAutoresizingMaskIntoConstraints = false
        return gameContentStack
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        let view = UIView(frame: contentView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = [0.0, 0.45, 0.55, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        awayStack.addArrangedSubviews([awaySchoolLabel, awayMascotLabel, awayScoreLabel])
        homeStack.addArrangedSubviews([homeSchoolLabel, homeMascotLabel, homeScoreLabel])
        teamsContentStack.addArrangedSubviews([awayStack, homeStack])
        
        gameContentStack.addArrangedSubviews([dateLabel, rinkLabel])

        contentView.addSubviews([awayImageView, homeImageView, view, blurEffectView, teamsContentStack, gameContentStack])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            awayImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            awayImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            awayImageView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            awayImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            homeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            homeImageView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            homeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            homeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            teamsContentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            teamsContentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            teamsContentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
        ])
        
        NSLayoutConstraint.activate([
            gameContentStack.topAnchor.constraint(greaterThanOrEqualTo: teamsContentStack.bottomAnchor, constant: 4.0),
            gameContentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            gameContentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            gameContentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
        ])
    }

    // MARK: Setter

    public func set(with game: Game) {
        awayImageView.image = UIImage(named: "ZoomedUGA")
        awaySchoolLabel.text = game.getOpponentName()
        awayMascotLabel.text = "Away Mascot"
        awayScoreLabel.text = String(describing: game.getOpponentScore())
        
        homeImageView.image = UIImage(named: "ZoomedBuzz")
        homeSchoolLabel.text = "Georgia Tech"
        homeMascotLabel.text = "Home Mascot"
        homeScoreLabel.text = String(describing: game.getGTScore())
        
        dateLabel.text = game.getDateTime().formatted
        rinkLabel.text = game.getRinkName()
        
//        imageView.sd_setImagewith: game.getImageURL(), placeholderImage: nil)
    }

}
