//
//  SettingsTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/23/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol SettingsTableViewFooterDelegate {
    func signoutButtonTapped(with signoutButton: PillButton)
}

class SettingsTableViewFooter: UIView {

    // MARK: Properties

    private let signoutButton = PillButton(title: "Sign out", backgroundColor: .lossRed, borderColor: .lossRed, isEnabled: true)
    public var delegate: SettingsTableViewFooterDelegate!

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        signoutButton.addTarget(self, action: #selector(signoutButtonTapped), for: .touchUpInside)

        addSubview(signoutButton)
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            signoutButton.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            signoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            signoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            signoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0)
        ])
    }

    // MARK: Action

    @objc private func signoutButtonTapped() {
        delegate.signoutButtonTapped(with: signoutButton)
        signoutButton.isLoading = true
    }

}
