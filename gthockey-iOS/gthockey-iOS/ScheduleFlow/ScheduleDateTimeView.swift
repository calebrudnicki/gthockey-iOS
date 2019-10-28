//
//  ScheduleDateTimeView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ScheduleDateTimeView: UIView {

    // MARK: Properties

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.numberOfLines = 1
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.numberOfLines = 1
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()

    private let detailsStack: UIStackView = {
        let detailsStack = UIStackView()
        detailsStack.axis = .vertical
        detailsStack.distribution = .fillProportionally
        detailsStack.alignment = .center
        detailsStack.translatesAutoresizingMaskIntoConstraints = false
        return detailsStack
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        detailsStack.addArrangedSubview(dateLabel)
        detailsStack.addArrangedSubview(timeLabel)

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

    public func set(with date: Date) {
        dateLabel.text = formatDate(from: date)
        timeLabel.text = formatTime(from: date)
    }

    // MARK: Date & Time

    private func formatDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy"
        return formatter.string(from: date)
    }

    private func formatTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }

}
