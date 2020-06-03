//
//  ScheduleCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class ScheduleCollectionViewCell: GTHCardCollectionViewCell {

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
    
    private let topContentView: UIView = {
        let topContentView = UIView()
        topContentView.translatesAutoresizingMaskIntoConstraints = false
        return topContentView
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
        
        layer.applySketchShadow(color: .black, alpha: 0.5, x: 0.0, y: 16.0, blur: 16.0, spread: 0.0)
        contentView.layer.cornerRadius = 14.0
        contentView.layer.masksToBounds = true
        
        awayStack.addArrangedSubviews([awaySchoolLabel, awayMascotLabel, awayScoreLabel])
        homeStack.addArrangedSubviews([homeSchoolLabel, homeMascotLabel, homeScoreLabel])
        teamsContentStack.addArrangedSubviews([awayStack, homeStack])
        topContentView.addSubview(teamsContentStack)
        
        gameContentStack.addArrangedSubviews([dateLabel, rinkLabel])

        contentView.addSubviews([awayImageView, homeImageView, view, blurEffectView, topContentView, gameContentStack])
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
            topContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topContentView.bottomAnchor.constraint(equalTo: gameContentStack.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            teamsContentStack.centerYAnchor.constraint(equalTo: topContentView.centerYAnchor),
            teamsContentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            teamsContentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
        ])
        
        NSLayoutConstraint.activate([
            gameContentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            gameContentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            gameContentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
        ])
    }

    // MARK: Setter

    public func set(with game: Game) {
        awayImageView.image = game.venue == .Home ? UIImage(named: "ZoomedUGA") : UIImage(named: "ZoomedBuzz")
        awaySchoolLabel.text = game.venue == .Home ? game.opponent.schoolName : "Georgia Tech"
        awayMascotLabel.text = game.venue == .Home ? game.opponent.mascotName : "Yellow Jackets"
        
        homeImageView.image = game.venue == .Home ? UIImage(named: "ZoomedBuzz") : UIImage(named: "ZoomedUGA")
        homeSchoolLabel.text = game.venue == .Home ? "Georgia Tech" : game.opponent.schoolName
        homeMascotLabel.text = game.venue == .Home ? "Yellow Jackets" : game.opponent.mascotName
            
        if let opponentScore = game.opponentScore, let gtScore = game.gtScore {
            awayScoreLabel.text = game.venue == .Home ? String(describing: opponentScore) : String(describing: gtScore)
            homeScoreLabel.text = game.venue == .Home ? String(describing: gtScore) : String(describing: opponentScore)
        } else {
            awayScoreLabel.text = ""
            homeScoreLabel.text = ""
        }
        
        dateLabel.text = game.dateTime.formatted
        rinkLabel.text = game.rinkName
    }

}
