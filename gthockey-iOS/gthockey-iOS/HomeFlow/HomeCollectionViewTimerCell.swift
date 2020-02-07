//
//  HomeCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 2/07/2020.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCollectionViewTimerCell: UICollectionViewCell {
    
    // MARK: Properties
    private var seasonRecordTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 32.0)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .techGold
        titleLabel.text = "Season Record"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
        
    }()
    
    private var seasonRecordLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 60)
        titleLabel.textAlignment = .center
        if #available(iOS 13.0, *) {
            titleLabel.textColor = .label
        }
        else {
            titleLabel.textColor = .black
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
        
    }()
    
    private var nextGameTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 32.0)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .techGold
        titleLabel.text = "Next Game"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
        
    }()
    
    
    private let awayTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let awayTeamStackView: UIStackView = {
        let awayTeamStackView = UIStackView()
        awayTeamStackView.axis = .vertical
        awayTeamStackView.distribution = .fillProportionally
        awayTeamStackView.spacing = 4.0
        awayTeamStackView.translatesAutoresizingMaskIntoConstraints = false
        return awayTeamStackView
    }()
    
    private let awayTeamMascot: UILabel = {
        let awayTeamLabel = UILabel()
        awayTeamLabel.numberOfLines = 0
        awayTeamLabel.sizeToFit()
        awayTeamLabel.textAlignment = .center
        awayTeamLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        awayTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return awayTeamLabel
    }()
    
    private let awayTeamTitle: UILabel = {
        let awayTeamTitle = UILabel()
        awayTeamTitle.numberOfLines = 0
        awayTeamTitle.sizeToFit()
        awayTeamTitle.textAlignment = .center
        awayTeamTitle.font = UIFont(name: "Helvetica Neue", size: 32.0)
        awayTeamTitle.translatesAutoresizingMaskIntoConstraints = false
        return awayTeamTitle
    }()
    
    
    private let resultStackView: UIStackView = {
        let resultStackView = UIStackView()
        resultStackView.axis = .vertical
        resultStackView.distribution = .fillProportionally
        resultStackView.spacing = 4.0
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        return resultStackView
    }()
    
    private let scheduleDateTimeView: ScheduleDateTimeView = {
        let dateTimeView = ScheduleDateTimeView()
        //dateTimeView.backgroundColor = .lightGray
        dateTimeView.changeDateTextSize(newSize: 18.0)
        dateTimeView.changeTimeTextSize(newSize: 18.0)
        dateTimeView.makeTimeFirst()
        dateTimeView.layer.cornerRadius = 6.0
        return dateTimeView
    }()
    
    private let rinkLabel: UILabel = {
        let rinkLabel = UILabel()
        rinkLabel.numberOfLines = 0
        rinkLabel.sizeToFit()
        rinkLabel.textAlignment = .center
        rinkLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        rinkLabel.translatesAutoresizingMaskIntoConstraints = false
        return rinkLabel
    }()
    
    
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
            layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
            layer.shadowColor = UIColor.label.cgColor
        } else {
            layer.shadowColor = UIColor.black.cgColor
        }
        
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 7.0
        layer.cornerRadius = 6.0
        
        contentView.layer.cornerRadius = 6.0
        contentView.layer.masksToBounds = true
        
        awayTeamStackView.addArrangedSubview(awayTeamTitle)
        
        resultStackView.addArrangedSubview(rinkLabel)
        resultStackView.addArrangedSubview(scheduleDateTimeView)
        
        contentView.addSubviews([seasonRecordTitleLabel, seasonRecordLabel, nextGameTitleLabel, awayTeamImageView, awayTeamStackView, resultStackView])
        updateConstraints()
        
        
        //MARK: Remove this code, as it inits default test values to ensure UI works and add functions to actually get data
        seasonRecordLabel.text = "13-5-3-0"
        awayTeamImageView.image = UIImage(named: "Buzz")
        awayTeamMascot.text = "Yellow Jackets"
        awayTeamTitle.text = "Georgia Tech"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: "2020-02-07")!
        
        scheduleDateTimeView.set(with: date)
        
        rinkLabel.text = "Ford Ice Center - Bellevue"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            seasonRecordTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonRecordTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seasonRecordTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            seasonRecordLabel.topAnchor.constraint(equalTo: seasonRecordTitleLabel.bottomAnchor),
            seasonRecordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seasonRecordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextGameTitleLabel.topAnchor.constraint(equalTo: seasonRecordLabel.bottomAnchor, constant: 45.0),
            nextGameTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nextGameTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            awayTeamImageView.topAnchor.constraint(equalTo: nextGameTitleLabel.bottomAnchor, constant: 16.0),
            awayTeamImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            awayTeamImageView.widthAnchor.constraint(equalToConstant: 120.0),
            awayTeamImageView.heightAnchor.constraint(equalTo: awayTeamImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            awayTeamStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            awayTeamStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            awayTeamStackView.topAnchor.constraint(equalTo: awayTeamImageView.bottomAnchor, constant: 10.0)
        ])
        
        NSLayoutConstraint.activate([
            resultStackView.topAnchor.constraint(equalTo: awayTeamStackView.bottomAnchor, constant: 25.0),
            resultStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            resultStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
        ])

        
        
        super.updateConstraints()
    }
    
    // MARK: Setter
    
    public func set(with record: String, nextGame: Game) {
       
    }
    
}

