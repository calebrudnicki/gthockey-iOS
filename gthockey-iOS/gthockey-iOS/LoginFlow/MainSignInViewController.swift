//
//  MainSignInViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/11/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainSignInViewController: UIViewController {

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
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()

    private var sendEmailButton = PillButton(title: "Send email", backgroundColor: .techGold, borderColor: .techGold, isEnabled: true)

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

        sendEmailButton.addTarget(self, action: #selector(sendEmailButtonTapped), for: .touchUpInside)

        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(sendEmailButton)

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

    @objc private func sendEmailButtonTapped() {
        let settings = AuthenticationManager().contructActionCodeSettings(for: emailTextField.text!)

        AuthenticationManager().sendSignInLink(to: emailTextField.text!, with: settings, { error in
            if let error = error {
                //Could not send sign in email
                let errorAlert = UIAlertController(title: "Could not send email",
                                                   message: "Error was found. \(error).",
                                                   preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(errorAlert, animated: true, completion: nil)
            }

            //Sign in email was sent successfully
            let successAlert = UIAlertController(title: "Verification email has been sent",
                                                 message: "An email has been sent to \(self.emailTextField.text!). Use the link found in the email to complete the sign in process.",
                                                 preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "Ok", style: .default))
            successAlert.addAction(UIAlertAction(title: "Open email", style: .default, handler: { action in
                let mailURL = URL(string: "message://")!
                if UIApplication.shared.canOpenURL(mailURL) {
                    UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
                }
            }))
            self.present(successAlert, animated: true, completion: nil)
        })
    }

}
