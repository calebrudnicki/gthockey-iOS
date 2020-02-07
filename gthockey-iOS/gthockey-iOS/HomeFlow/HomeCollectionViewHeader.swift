//
//  RosterCollectionViewHeader.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/7/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class HomeCollectionViewHeader: UICollectionReusableView {

    // MARK: Properties

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name:"HelveticaNeue-Light", size: 24.0)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)

        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 12.0),
            titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -12.0)
        ])
    }

    // MARK: Setter

    public func set(with title: String) {
        titleLabel.text = title
        titleLabel.textColor = .gray
    }

}
