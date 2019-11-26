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

    private var firstName: String?
    private var lastName: String?

    private let logoImageView: UIImageView = {
        let logoImage = UIImage(named: "BuzzOnlyLogo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()

    private let welcomeButtonsView = WelcomeButtonsView()
    private let signupView = SignupView()
    private let loginView = LoginView()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .techNavy
        
        welcomeButtonsView.delegate = self

        signupView.delegate = self
        signupView.isHidden = true
        signupView.alpha = 0.0

        loginView.delegate = self
        loginView.isHidden = true
        loginView.alpha = 0.0

        view.addSubviews([logoImageView, welcomeButtonsView, signupView, loginView])
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
            signupView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            signupView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
            signupView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0)
        ])

        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
        ])

        NSLayoutConstraint.activate([
            welcomeButtonsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            welcomeButtonsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
            welcomeButtonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0)
        ])
    }

}

extension WelcomeViewController: WelcomeButtonsViewDelegate {

    func didTapSignupButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.welcomeButtonsView.alpha = 0.0
            self.signupView.alpha = 1.0
        }, completion: { _ in
            self.welcomeButtonsView.isHidden = true
            self.signupView.isHidden = false
        })
    }

    func didTapLoginButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.welcomeButtonsView.alpha = 0.0
            self.loginView.alpha = 1.0
        }, completion: { _ in
            self.welcomeButtonsView.isHidden = true
            self.loginView.isHidden = false
        })
    }

}

extension WelcomeViewController: SignupViewDelegate {

    func didTapSignupButton(with firstName: String, _ lastName: String, _ email: String, _ password: String) {
        self.firstName = firstName
        self.lastName = lastName

        let authentificator = Authentificator()
        authentificator.createUser(with: firstName, lastName, email, password) { result, error in
            if result {
                self.switchToLogin(with: email, password: password)
            } else {
                let alert = UIAlertController(title: "Sign Up Failed",
                                          message: error?.localizedDescription,
                                          preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    func switchToLogin(with email: String?, password: String?) {
        if let email = email, let password = password {
            loginView.setFields(with: email, password: password)
        }

        UIView.animate(withDuration: 0.5, animations: {
            self.signupView.alpha = 0.0
            self.loginView.alpha = 1.0
        }, completion: { _ in
            self.signupView.isHidden = true
            self.loginView.isHidden = false
        })
    }

}

extension WelcomeViewController: LoginViewDelegate {

    func didTapLoginButton(with email: String, _ password: String) {
        let authentificator = Authentificator()
        authentificator.login(with: email, password, firstName, lastName) { result, error in
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

    func switchToSignup() {
        UIView.animate(withDuration: 0.5, animations: {
            self.loginView.alpha = 0.0
            self.signupView.alpha = 1.0
        }, completion: { _ in
            self.loginView.isHidden = true
            self.signupView.isHidden = false
        })
    }

}
