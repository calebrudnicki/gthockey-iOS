//
//  ScheduleCollectionViewSectionHeader.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ScheduleCollectionViewSectionHeader: UICollectionReusableView {
    
    // MARK: Properties

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.DINCondensed.bold.font(size: 32.0)
        titleLabel.textColor = UIColor.scheduleHeaderTitleColor
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let recordLabel: UILabel = {
        let recordLabel = UILabel()
        recordLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        recordLabel.textColor = UIColor.scheduleHeaderRecordColor
        recordLabel.numberOfLines = 1
        recordLabel.textAlignment = .right
        recordLabel.sizeToFit()
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        return recordLabel
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews([titleLabel, recordLabel])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            titleLabel.trailingAnchor.constraint(equalTo: recordLabel.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            recordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
            recordLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Setter

    public func set(with title: String, _ record: String? = "") {
        titleLabel.text = title
        recordLabel.text = record
    }
        
}
