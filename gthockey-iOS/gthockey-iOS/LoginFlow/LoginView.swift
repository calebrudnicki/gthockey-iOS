//
//  LoginView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/14/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//
//
//import UIKit
//
//protocol LoginViewDelegate {
//    func didTapLoginButton(with email: String, _ password: String, _ loginButton: PillButton)
//    func didTapFinalLoginButton(with email: String, _ finalLoginButton: PillButton)
//    func switchToSignup()
//    func forgotPassword(with email: String)
//    func promptUserForValidEmail()
//}
//
//class LoginView: UIView {
//
//    // MARK: Properties
//
//    public var delegate: LoginViewDelegate?
//
//    private let emailVerificationLabel: UILabel = {
//        let emailVerificationLabel = UILabel()
//        emailVerificationLabel.text = "Check your email to verify your account before continuing."
//        emailVerificationLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
//        emailVerificationLabel.textColor = .gray
//        emailVerificationLabel.numberOfLines = 2
//        emailVerificationLabel.textAlignment = .center
//        emailVerificationLabel.isHidden = true
//        emailVerificationLabel.translatesAutoresizingMaskIntoConstraints = false
//        return emailVerificationLabel
//    }()
//
//    private let textFieldStackView: UIStackView = {
//        let textFieldStackView = UIStackView()
//        textFieldStackView.axis = .vertical
//        textFieldStackView.distribution = .fillEqually
//        textFieldStackView.spacing = 12.0
//        textFieldStackView.backgroundColor = .techNavy
//        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
//        return textFieldStackView
//    }()
//
//    private let emailTextField: UITextField = {
//        let emailTextField = UITextField()
//        emailTextField.textColor = .white
//        emailTextField.keyboardType = .emailAddress
//        emailTextField.autocapitalizationType = .none
//        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
//        emailTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
//        emailTextField.translatesAutoresizingMaskIntoConstraints = false
//        return emailTextField
//    }()
//
//    private let passwordTextField: UITextField = {
//        let passwordTextField = UITextField()
//        passwordTextField.isSecureTextEntry = true
//        passwordTextField.textColor = .white
//        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
//        passwordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        return passwordTextField
//    }()
//
//    private let loginButton = PillButton(title: "Log in", backgroundColor: .techGold, borderColor: .techGold, isEnabled: false)
//
//    private let finalLoginButton = PillButton(title: "Post email Log in", backgroundColor: .cyan, borderColor: .green, isEnabled: true)
//
//    private let switchToSignupButton: UIButton = {
//        let switchToSignupButton = UIButton()
//        switchToSignupButton.setTitle("Are you a new user?", for: .normal)
//        switchToSignupButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
//        switchToSignupButton.titleLabel?.textColor = .gray
//        switchToSignupButton.translatesAutoresizingMaskIntoConstraints = false
//        return switchToSignupButton
//    }()
//
//    private let forgotPasswordButton: UIButton = {
//        let forgotPasswordButton = UIButton()
//        forgotPasswordButton.setTitle("Forgot password?", for: .normal)
//        forgotPasswordButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
//        forgotPasswordButton.titleLabel?.textColor = .gray
//        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
//        return forgotPasswordButton
//    }()
//
//    // MARK: Init
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        emailTextField.addTarget(self, action: #selector(validateTextFields), for: .editingChanged)
//        passwordTextField.addTarget(self, action: #selector(validateTextFields), for: .editingChanged)
//        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//        finalLoginButton.addTarget(self, action: #selector(finalLoginButtonTapped), for: .touchUpInside)
//        switchToSignupButton.addTarget(self, action: #selector(switchToSignupButtonTapped), for: .touchUpInside)
//        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
//
//        textFieldStackView.addArrangedSubview(emailTextField)
//        textFieldStackView.addArrangedSubview(passwordTextField)
//
//        addSubviews([emailVerificationLabel, textFieldStackView, loginButton, finalLoginButton, switchToSignupButton, forgotPasswordButton])
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
//            emailVerificationLabel.topAnchor.constraint(equalTo: topAnchor),
//            emailVerificationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            emailVerificationLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            textFieldStackView.topAnchor.constraint(equalTo: emailVerificationLabel.bottomAnchor, constant: 12.0),
//            textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            textFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 16.0),
//            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            finalLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16.0),
//            finalLoginButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            finalLoginButton.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            switchToSignupButton.topAnchor.constraint(equalTo: finalLoginButton.bottomAnchor, constant: 8.0),
//            switchToSignupButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            switchToSignupButton.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            forgotPasswordButton.topAnchor.constraint(equalTo: switchToSignupButton.bottomAnchor, constant: 4.0),
//            forgotPasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor),
//            forgotPasswordButton.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    // MARK: Actions
//
//    @objc private func validateTextFields() {
//        guard
//            let emailText = emailTextField.text,
//            let passwordText = passwordTextField.text
//        else { return }
//
//        if emailText.contains("@") && passwordText.count > 6 {
//            loginButton.isEnabled = true
//        } else {
//            loginButton.isEnabled = false
//        }
//    }
//
//    @objc private func loginButtonTapped() {
//        guard
//            let email = emailTextField.text,
//            let password = passwordTextField.text,
//            email.count > 0,
//            password.count > 0
//        else { return }
//
//        loginButton.isLoading = true
//        delegate?.didTapLoginButton(with: email, password, loginButton)
//    }
//
//    @objc private func finalLoginButtonTapped() {
//        guard
//            let email = emailTextField.text,
//            let password = passwordTextField.text,
//            email.count > 0,
//            password.count > 0
//        else { return }
//
//        delegate?.didTapFinalLoginButton(with: email, finalLoginButton)
//    }
//
//    @objc private func switchToSignupButtonTapped() {
//        delegate?.switchToSignup()
//    }
//
//    @objc private func forgotPasswordButtonTapped() {
//        guard
//            let email = emailTextField.text,
//            email.count > 0,
//            email.contains("@")
//        else {
//            delegate?.promptUserForValidEmail()
//            return
//        }
//
//        delegate?.forgotPassword(with: email)
//    }
//
//    // MARK: Public Functions
//
//    public func setFields(with email: String, password: String) {
//        emailTextField.text = email
//        passwordTextField.text = password
//        loginButton.isEnabled = true
//        emailVerificationLabel.isHidden = false
//    }
//
//}
