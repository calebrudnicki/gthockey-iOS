//
//  WelcomeButtonsView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/14/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

//import UIKit
//
//protocol WelcomeButtonsViewDelegate {
//    func didTapSignupButton()
//    func didTapLoginButton()
//}
//
//class WelcomeButtonsView: UIView {
//
//    // MARK: Properties
//
//    public var delegate: WelcomeButtonsViewDelegate?
//
//    private let buttonsStackView: UIStackView = {
//        let buttonsStackView = UIStackView()
//        buttonsStackView.axis = .vertical
//        buttonsStackView.distribution = .fillEqually
//        buttonsStackView.spacing = 12.0
//        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
//        return buttonsStackView
//    }()
//
//    private let signupButton = PillButton(title: "Sign Up", backgroundColor: .techNavy, borderColor: .techGold, isEnabled: true)
//    private let loginButton = PillButton(title: "Log In", backgroundColor: .techGold, borderColor: .techGold, isEnabled: true)
//
//    // MARK: Init
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
//        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//
//        buttonsStackView.addArrangedSubview(signupButton)
//        buttonsStackView.addArrangedSubview(loginButton)
//
//        addSubview(buttonsStackView)
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
//            buttonsStackView.topAnchor.constraint(equalTo: topAnchor),
//            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    // MARK: Actions
//
//    @objc private func signupButtonTapped() {
//        delegate?.didTapSignupButton()
//        signupButton.isLoading = true
//    }
//
//    @objc private func loginButtonTapped() {
//        delegate?.didTapLoginButton()
//        loginButton.isLoading = true
//    }
//
//}
