//
//  WelcomeViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: Properties

    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "WelcomePic")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()

    private let signupButton = PillButton(title: "Sign Up", fillColor: .techGold)
    private let loginButton = PillButton(title: "Log In", fillColor: .techNavy)

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        view.addSubviews([backgroundImage, signupButton, loginButton])
        updateViewConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            signupButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            signupButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
            signupButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])

        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 12.0),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])
    }

    // MARK: Actions

    @objc private func signupButtonTapped() {
        let signupViewController = SignupViewController()
        signupViewController.modalPresentationStyle = .fullScreen
        present(signupViewController, animated: true, completion: nil)
    }

    @objc private func loginButtonTapped() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }

}
