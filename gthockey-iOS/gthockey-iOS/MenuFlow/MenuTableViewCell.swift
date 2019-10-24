//
//  MenuTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/23/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    private let scheduleOpponentRinkView = ScheduleOpponentRinkView()
    private let scheduleDateTimeView = ScheduleDateTimeView()
    private let scheduleResultView = ScheduleResultView()
    private var gameIsReported: Bool = false

    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
    }()

    private let optionLabel: UILabel = {
        let optionLabel = UILabel()
        optionLabel.font = UIFont(name:"HelveticaNeue-Light", size: 20.0)
        optionLabel.textColor = .white
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        return optionLabel
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .techNavy

        contentView.addSubviews([iconImageView, optionLabel])

        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            iconImageView.heightAnchor.constraint(equalToConstant: 24.0),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            optionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12.0),
            optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
        ])
    }

    public func set(with menuOption: MenuOption) {
        iconImageView.image = menuOption.image
        optionLabel.text = menuOption.description
    }
}

