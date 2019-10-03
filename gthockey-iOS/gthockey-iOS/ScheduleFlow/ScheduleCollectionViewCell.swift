//
//  ScheduleCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {

    private let scheduleOpponentRinkView = ScheduleOpponentRinkView()
    private let scheduleDateTimeView = ScheduleDateTimeView()
    private let scheduleResultView = ScheduleResultView()
    private var gameIsReported: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.backgroundColor = UIColor.white.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 7.0
        layer.cornerRadius = 6.0

        contentView.layer.cornerRadius = 6.0
        contentView.layer.masksToBounds = true

        contentView.addSubview(scheduleOpponentRinkView)
        contentView.addSubview(scheduleDateTimeView)
        contentView.addSubview(scheduleResultView)

        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            scheduleOpponentRinkView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            scheduleOpponentRinkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            scheduleOpponentRinkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            scheduleOpponentRinkView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7)
        ])

        if gameIsReported {
            NSLayoutConstraint.activate([
                scheduleResultView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
                scheduleResultView.leadingAnchor.constraint(equalTo: scheduleOpponentRinkView.trailingAnchor, constant: 16.0),
                scheduleResultView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0),
                scheduleResultView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
            ])
        } else {
            NSLayoutConstraint.activate([
                scheduleDateTimeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
                scheduleDateTimeView.leadingAnchor.constraint(equalTo: scheduleOpponentRinkView.trailingAnchor, constant: 16.0),
                scheduleDateTimeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0),
                scheduleDateTimeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
            ])
        }

    }

    public func set(with game: Game) {
        scheduleOpponentRinkView.set(with: game.getOpponentName(), game.getRinkName())

        if game.getIsReported() {
            scheduleResultView.set(with: game.getShortResult(), "\(game.getGTScore()) - \(game.getOpponentScore())")
            gameIsReported = true
            contentView.addSubview(scheduleResultView)
            scheduleDateTimeView.removeFromSuperview()
        } else {
            scheduleDateTimeView.set(with: game.getDateTime())
            gameIsReported = false
            contentView.addSubview(scheduleDateTimeView)
            scheduleResultView.removeFromSuperview()
        }

        updateConstraints()

    }

}
