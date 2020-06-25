//
//  AdminUsersTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/12/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

//import UIKit
//
//protocol AdminUsersTableViewFooterDelegate {
//    func addAdminUserButtonTapped(with addAdminUserButton: PillButton)
//}
//
//class AdminUsersTableViewFooter: UIView {
//
//    // MARK: Properties
//
//    private let addAdminUserButton = PillButton(title: "Add admin user", backgroundColor: .techNavy, borderColor: .techNavy, isEnabled: true)
//    public var delegate: AdminUsersTableViewFooterDelegate!
//
//    // MARK: Init
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        addAdminUserButton.addTarget(self, action: #selector(addAdminUserButtonTapped), for: .touchUpInside)
//
//        addSubview(addAdminUserButton)
//        updateConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func updateConstraints() {
//        super.updateConstraints()
//
//        NSLayoutConstraint.activate([
//            addAdminUserButton.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
//            addAdminUserButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
//            addAdminUserButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
//            addAdminUserButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0)
//        ])
//    }
//
//    // MARK: Action
//
//    @objc private func addAdminUserButtonTapped() {
//        delegate.addAdminUserButtonTapped(with: addAdminUserButton)
//        addAdminUserButton.isLoading = true
//    }
//
//}
