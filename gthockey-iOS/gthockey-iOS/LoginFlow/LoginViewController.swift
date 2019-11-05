//
//  LoginViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/1/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: Properties

    private let closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()

    private let textFieldStackView: UIStackView = {
        let textFieldStackView = UIStackView()
        textFieldStackView.axis = .vertical
        textFieldStackView.distribution = .equalCentering
        textFieldStackView.spacing = 8.0
        textFieldStackView.backgroundColor = .techNavy
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        return textFieldStackView
    }()

    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.backgroundColor = .gray
        emailTextField.textColor = .black
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()

    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .gray
        passwordTextField.textColor = .black
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()

    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = .winGreen
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .techGold

        var closeButtonImage: UIImage?

        if traitCollection.userInterfaceStyle == .dark {
            closeButtonImage = UIImage(named: "CloseButtonWhite")?.withRenderingMode(.alwaysOriginal)
        } else {
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
        }

        closeButton.setImage(closeButtonImage, for: .normal)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        loginButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)

        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)

        view.addSubviews([closeButton, textFieldStackView, loginButton])
        updateViewConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
           closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
           closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12.0)
        ])

        NSLayoutConstraint.activate([
            textFieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textFieldStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])

        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 12.0),
            loginButton.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])
    }

    // MARK: Actions

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func logInButtonTapped() {
        guard
            let email = emailTextField.text?.lowercased(),
            let password = passwordTextField.text?.lowercased(),
            email.count > 0,
            password.count > 0
        else { return }

        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                let menuContainerViewController = MenuContainerViewController()
                menuContainerViewController.modalPresentationStyle = .fullScreen
                self.present(menuContainerViewController, animated: true, completion: nil)
            }
        }
    }

}
