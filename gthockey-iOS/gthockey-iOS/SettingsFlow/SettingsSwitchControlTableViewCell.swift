//
//  SettingsSwitchControlTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/14/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol SettingsSwitchControlTableViewCellDelegate {
    func cellDidDetechTap()
}

class SettingsSwitchControlTableViewCell: UITableViewCell {

    // MARK: Properties

    public var delegate: SettingsSwitchControlTableViewCellDelegate!

    private let cellLabel: UILabel = {
        let cellLabel = UILabel()
        cellLabel.font = UIFont(name: "Helvetica Neue", size: 20.0)
        cellLabel.numberOfLines = 1
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        return cellLabel
    }()

    // MARK: Init

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryType = .disclosureIndicator
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))

        contentView.addSubviews([cellLabel])
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0)
        ])
    }

    // MARK: Action

    @objc private func cellTapped() {
        delegate?.cellDidDetechTap()
    }

    // MARK: Setter

    public func set(with title: String) {
        cellLabel.text = title
    }

}
