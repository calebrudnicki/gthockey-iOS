//
//  ScheduleOpponentRinkView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ScheduleOpponentRinkView: UIView {

    // MARK: Properties

    private let opponentLabel: UILabel = {
        let opponentLabel = UILabel()
        opponentLabel.font = UIFont(name:"Helvetica Neue", size: 20.0)
        opponentLabel.adjustsFontSizeToFitWidth = true
        opponentLabel.numberOfLines = 1
        opponentLabel.translatesAutoresizingMaskIntoConstraints = false
        return opponentLabel
    }()

    private let rinkLabel: UILabel = {
        let venueLabel = UILabel()
        venueLabel.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        venueLabel.adjustsFontSizeToFitWidth = true
        venueLabel.numberOfLines = 1
        venueLabel.translatesAutoresizingMaskIntoConstraints = false
        return venueLabel
    }()

    private let detailsStack: UIStackView = {
        let detailsStack = UIStackView()
        detailsStack.axis = .vertical
        detailsStack.distribution = .fillProportionally
        detailsStack.translatesAutoresizingMaskIntoConstraints = false
        return detailsStack
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        detailsStack.addArrangedSubview(opponentLabel)
        detailsStack.addArrangedSubview(rinkLabel)

        addSubview(detailsStack)

        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            detailsStack.topAnchor.constraint(equalTo: topAnchor),
            detailsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Setter

    public func set(with opponent: String, _ rink: String, _ venue: String) {
        if venue == "H" {
            opponentLabel.text = "vs \(opponent)"
        } else {
            opponentLabel.text = "at \(opponent)"
        }
        rinkLabel.text = rink
    }

}
