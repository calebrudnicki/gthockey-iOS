//
//  SignupViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

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

    private let firstNameTextField: UITextField = {
        let firstNameTextField = UITextField()
//        firstNameTextField.layer.borderColor = UIColor.techGold.cgColor
//        firstNameTextField.layer.borderWidth = 1
        firstNameTextField.textColor = .white
        firstNameTextField.placeholder = "First name"
        firstNameTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)

        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 75.0, width: firstNameTextField.frame.size.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        firstNameTextField.borderStyle = .none
        firstNameTextField.layer.addSublayer(bottomLine)

        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return firstNameTextField
    }()

    private let lastNameTextField: UITextField = {
        let lastNameTextField = UITextField()
        lastNameTextField.layer.borderColor = UIColor.techGold.cgColor
        lastNameTextField.layer.borderWidth = 1
        lastNameTextField.textColor = .white
        lastNameTextField.placeholder = "Last name"
        lastNameTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return lastNameTextField
    }()

    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.layer.borderColor = UIColor.techGold.cgColor
        emailTextField.layer.borderWidth = 1
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
        passwordTextField.layer.borderColor = UIColor.techGold.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.textColor = .white
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()

    private let signupButton: UIButton = {
        let signupButton = UIButton()
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.backgroundColor = .techGold
        signupButton.layer.cornerRadius = 30
        signupButton.clipsToBounds = true
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        return signupButton
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .techNavy

        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide(notification:)))
        view.addGestureRecognizer(tap)

        var closeButtonImage: UIImage?

        if traitCollection.userInterfaceStyle == .dark {
            closeButtonImage = UIImage(named: "CloseButtonWhite")?.withRenderingMode(.alwaysOriginal)
        } else {
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
        }

        closeButton.setImage(closeButtonImage, for: .normal)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))
        
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)

<<<<<<< HEAD
=======
//        firstNameTextField.becomeFirstResponder()

>>>>>>> 69a478654c9fdbbbad5e277eaa8a1f3430c677ba
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        textFieldStackView.addArrangedSubview(firstNameTextField)
        textFieldStackView.addArrangedSubview(lastNameTextField)
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)

        view.addSubviews([closeButton, textFieldStackView, signupButton])
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
            signupButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 12.0),
            signupButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            signupButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
            signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            signupButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])
    }

    // MARK: Action

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
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

        let authentificator = Authentificator()
        authentificator.signup(with: firstName, lastName, email, password) { result, error in
            if result {
                let menuContainerViewController = MenuContainerViewController()
                menuContainerViewController.modalPresentationStyle = .fullScreen
                self.present(menuContainerViewController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Sign Up Failed",
                                          message: error?.localizedDescription,
                                          preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y -= keyboardSize.height
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        view.endEditing(true)
        view.frame.origin.y = 0
    }

}
