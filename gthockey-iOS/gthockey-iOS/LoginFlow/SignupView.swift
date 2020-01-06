//
//  SignupView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/14/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol SignupViewDelegate {
    func didTapSignupButton(with firstName: String, _ lastName: String, _ email: String, _ password: String, _ signupButton: PillButton)
    func switchToLogin(with email: String?, password: String?)
}

class SignupView: UIView {

    // MARK: Properties

    public var delegate: SignupViewDelegate?

    private let textFieldStackView: UIStackView = {
        let textFieldStackView = UIStackView()
        textFieldStackView.axis = .vertical
        textFieldStackView.distribution = .fillEqually
        textFieldStackView.spacing = 12.0
        textFieldStackView.backgroundColor = .techNavy
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        return textFieldStackView
    }()

    private let firstNameTextField: UITextField = {
        let firstNameTextField = UITextField()
        firstNameTextField.textColor = .white
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "First name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        firstNameTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return firstNameTextField
    }()

    private let lastNameTextField: UITextField = {
        let lastNameTextField = UITextField()
        lastNameTextField.textColor = .white
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lastNameTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return lastNameTextField
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
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password (7 character minimum)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()

    private let passwordConfirmTextField: UITextField = {
        let passwordConfirmTextField = UITextField()
        passwordConfirmTextField.isSecureTextEntry = true
        passwordConfirmTextField.textColor = .white
        passwordConfirmTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordConfirmTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        passwordConfirmTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordConfirmTextField
    }()

    private let signupButton = PillButton(title: "Sign up", backgroundColor: .techGold, borderColor: .techGold, isEnabled: false)

    private let switchToLoginButton: UIButton = {
        let switchToLoginButton = UIButton()
        switchToLoginButton.setTitle("Already a user?", for: .normal)
        switchToLoginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        switchToLoginButton.titleLabel?.textColor = .gray
        switchToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        return switchToLoginButton
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        firstNameTextField.addTarget(self, action: #selector(validateTextFields), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(validateTextFields), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(validateTextFields), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validateTextFields), for: .editingChanged)
        passwordConfirmTextField.addTarget(self, action: #selector(validateTextFields), for: .editingChanged)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        switchToLoginButton.addTarget(self, action: #selector(switchToLoginButtonTapped), for: .touchUpInside)

        textFieldStackView.addArrangedSubview(firstNameTextField)
        textFieldStackView.addArrangedSubview(lastNameTextField)
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        textFieldStackView.addArrangedSubview(passwordConfirmTextField)

        addSubviews([textFieldStackView, signupButton, switchToLoginButton])
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
            signupButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 16.0),
            signupButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            switchToLoginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 8.0),
            switchToLoginButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            switchToLoginButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            switchToLoginButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Actions

    @objc private func validateTextFields() {
        guard
            let firstNameText = firstNameTextField.text,
            let lastNameText = lastNameTextField.text,
            let emailText = emailTextField.text,
            let passwordText = passwordTextField.text,
            let passwordConfirmText = passwordConfirmTextField.text
        else { return }

        if firstNameText.count > 1 && lastNameText.count > 1 &&
            emailText.contains("@") && passwordText.count > 6
            && passwordText == passwordConfirmText {
            signupButton.isEnabled = true
        } else {
            signupButton.isEnabled = false
        }
    }

    @objc private func signupButtonTapped() {
        guard
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            firstName.count > 0,
            lastName.count > 0,
            email.count > 0,
            password.count > 0
        else { return }

        signupButton.isLoading = true
        delegate?.didTapSignupButton(with: firstName, lastName, email, password, signupButton)
    }

    @objc private func switchToLoginButtonTapped() {
        delegate?.switchToLogin(with: nil, password: nil)
    }

}
