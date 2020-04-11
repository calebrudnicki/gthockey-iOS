//
//  VerifyEmailSignInViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/11/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class VerifyEmailSignInViewController: UIViewController {

    // MARK: Properties

    private let logoImageView: UIImageView = {
        let logoImage = UIImage(named: "BuzzOnlyLogo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()

    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.textColor = .white
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Verify email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()

    private var signInButton = PillButton(title: "Sign in", backgroundColor: .techGold, borderColor: .techGold, isEnabled: true)

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12.0
        stackView.backgroundColor = .techNavy
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .techNavy

        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)

        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(signInButton)

        view.addSubviews([logoImageView, stackView])
        updateViewConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 128.0),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(greaterThanOrEqualTo: logoImageView.bottomAnchor, constant: 12.0),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12.0)
        ])
    }

    // MARK: Actions

    @objc private func signInButtonTapped() {
        AuthenticationManager().signIn(with: emailTextField.text!, { error in
            if let error = error {
                //Could not sign the user in
                let errorAlert = UIAlertController(title: "Could not complete sign in",
                                                   message: "Error was found. \(error).",
                                                   preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(errorAlert, animated: true, completion: nil)
            }

            //Sign in was successful
            let menuContainerViewController = MenuContainerViewController()
            menuContainerViewController.modalPresentationStyle = .fullScreen
            menuContainerViewController.modalTransitionStyle = .crossDissolve
            self.present(menuContainerViewController, animated: false, completion: nil)
        })
    }

}
