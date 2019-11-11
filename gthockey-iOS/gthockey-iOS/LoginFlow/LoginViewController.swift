//
//  LoginViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/1/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

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
        textFieldStackView.spacing = 18.0
        textFieldStackView.backgroundColor = .techNavy
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        return textFieldStackView
    }()

    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.textColor = .white
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()

    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .white
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()

    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Sign Up", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        loginButton.backgroundColor = .techGold
        loginButton.layer.cornerRadius = 30
        loginButton.clipsToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .techNavy

        var closeButtonImage: UIImage?

        if traitCollection.userInterfaceStyle == .dark {
            closeButtonImage = UIImage(named: "CloseButtonWhite")?.withRenderingMode(.alwaysOriginal)
        } else {
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
        }

        closeButton.setImage(closeButtonImage, for: .normal)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

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
           textFieldStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
           textFieldStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0)
        ])

        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 18.0),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])
    }

    // MARK: Actions

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func loginButtonTapped() {
        guard
            let email = emailTextField.text?.lowercased(),
            let password = passwordTextField.text?.lowercased(),
            email.count > 0,
            password.count > 0
        else { return }

        let authentificator = Authentificator()
        authentificator.login(with: email, password) { result, error in
            if result {
                let menuContainerViewController = MenuContainerViewController()
                menuContainerViewController.modalPresentationStyle = .fullScreen
                self.present(menuContainerViewController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Log In Failed",
                                          message: error?.localizedDescription,
                                          preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
