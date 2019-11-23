//
//  LoginView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/14/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol LoginViewDelegate {
    func didTapLoginButton(with email: String, _ password: String)
    func switchToSignup()
}

class LoginView: UIView {

    public var delegate: LoginViewDelegate?

    private let textFieldStackView: UIStackView = {
        let textFieldStackView = UIStackView()
        textFieldStackView.axis = .vertical
        textFieldStackView.distribution = .fillEqually
        textFieldStackView.spacing = 12.0
        textFieldStackView.backgroundColor = .techNavy
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        return textFieldStackView
    }()

    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.textColor = .white
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()

    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()

    private let loginButton = PillButton(title: "Log in", backgroundColor: .techGold, borderColor: .techGold, isEnabled: false)

    private let switchToSignupButton: UIButton = {
        let switchToSignupButton = UIButton()
        switchToSignupButton.setTitle("Are you a new user?", for: .normal)
        switchToSignupButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        switchToSignupButton.titleLabel?.textColor = .gray
        switchToSignupButton.translatesAutoresizingMaskIntoConstraints = false
        return switchToSignupButton
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        emailTextField.addTarget(self, action: #selector(validateTextFields), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validateTextFields), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        switchToSignupButton.addTarget(self, action: #selector(switchToSignupButtonTapped), for: .touchUpInside)

        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)

        addSubviews([textFieldStackView, loginButton, switchToSignupButton])
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: topAnchor),
            textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 18.0),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            switchToSignupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8.0),
            switchToSignupButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            switchToSignupButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            switchToSignupButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Action Functions

    @objc private func validateTextFields() {
        guard
            let emailText = emailTextField.text,
            let passwordText = passwordTextField.text
        else { return }

        if emailText.contains("@") && passwordText.count > 6 {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }

    @objc private func loginButtonTapped() {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            email.count > 0,
            password.count > 0
        else { return }

        delegate?.didTapLoginButton(with: email, password)
    }

    @objc private func switchToSignupButtonTapped() {
        delegate?.switchToSignup()
    }

}
