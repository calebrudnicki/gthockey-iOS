//
//  SettingsSwitchControlTableViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/14/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol SettingsSwitchControlTableViewCellDelegate {
    func switchControlToggled(to value: Bool)
}

class SettingsSwitchControlTableViewCell: UITableViewCell {

    // MARK: Properties

    public var delegate: SettingsSwitchControlTableViewCellDelegate!

    private let labelsStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillProportionally
        buttonsStackView.spacing = 4.0
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsStackView
    }()

    private let cellTitle: UILabel = {
        let cellTitle = UILabel()
        cellTitle.font = UIFont(name: "Helvetica Neue", size: 20.0)
        cellTitle.numberOfLines = 1
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        return cellTitle
    }()

    private let cellSubtitle: UILabel = {
        let cellSubtitle = UILabel()
        cellSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        cellSubtitle.textColor = .gray
        cellSubtitle.numberOfLines = 0
        cellSubtitle.sizeToFit()
        cellSubtitle.translatesAutoresizingMaskIntoConstraints = false
        return cellSubtitle
    }()

    private let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = .techNavy
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()

    // MARK: Init

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .gthBackgroundColor

        switchControl.addTarget(self, action: #selector(switchControlTapped), for: .valueChanged)

        labelsStackView.addArrangedSubview(cellTitle)
        labelsStackView.addArrangedSubview(cellSubtitle)

        contentView.addSubviews([labelsStackView, switchControl])
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: switchControl.leadingAnchor, constant: -12.0),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            switchControl.centerYAnchor.constraint(equalTo: labelsStackView.centerYAnchor),
            switchControl.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    // MARK: Action

    @objc private func switchControlTapped(sender: UISwitch) {
        delegate?.switchControlToggled(to: sender.isOn)
    }

    // MARK: Setter

    public func set(with title: String, subtitle: String) {
        cellTitle.text = title
        cellSubtitle.text = subtitle
        switchControl.isOn = UserDefaults.standard.bool(forKey: "isRegisteredForNotifications")
    }

}

