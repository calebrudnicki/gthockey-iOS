//
//  ScheduleResultView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ScheduleResultView: UIView {

    private let resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.font = UIFont(name:"Helvetica Neue", size: 20.0)
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.numberOfLines = 1
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()

    private let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.numberOfLines = 1
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return scoreLabel
    }()

    private let detailsStack: UIStackView = {
        let detailsStack = UIStackView()
        detailsStack.axis = .vertical
        detailsStack.distribution = .fillProportionally
        detailsStack.alignment = .center
        detailsStack.spacing = 4.0
        detailsStack.translatesAutoresizingMaskIntoConstraints = false
        return detailsStack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        detailsStack.addArrangedSubview(resultLabel)
        detailsStack.addArrangedSubview(scoreLabel)

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

    public func set(with result: String, _ score: String) {
        resultLabel.text = result
        if result == "W" {
            resultLabel.textColor = .winGreen
        } else {
            resultLabel.textColor = .lossRed
        }
        scoreLabel.text = score
    }

}

extension UIColor {

    static var winGreen = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 1.0)
    static var lossRed = UIColor(red: 178/255, green: 34/255, blue: 34/255, alpha: 1.0)

}
