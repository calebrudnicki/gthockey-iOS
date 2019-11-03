//
//  SignupViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
        firstNameTextField.backgroundColor = .gray
        firstNameTextField.textColor = .black
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return firstNameTextField
    }()

    private let lastNameTextField: UITextField = {
        let lastNameTextField = UITextField()
        lastNameTextField.backgroundColor = .gray
        lastNameTextField.textColor = .black
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return lastNameTextField
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

    private let signupButton: UIButton = {
        let signupButton = UIButton()
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.backgroundColor = .winGreen
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        return signupButton
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        var closeButtonImage: UIImage?

        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            closeButtonImage = UIImage(named: "CloseButtonWhite")?.withRenderingMode(.alwaysOriginal)
        } else {
            view.backgroundColor = .white
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
        }

        closeButton.setImage(closeButtonImage, for: .normal)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))
        
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)

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
           textFieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           textFieldStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           textFieldStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])

        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 12.0),
            signupButton.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor),
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

        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                let db = Firestore.firestore()
                guard let user = result?.user else { return }
                db.collection("users").document(user.uid).setData(["firstName": firstName,
                                                                   "lastName": lastName,
                                                                   "email": email,
                                                                   "uid": result?.user.uid,
                                                                   "cart": []]) { (error) in
                    if error != nil {
                        print(error?.localizedDescription)
                    }
                }

                let menuContainerViewController = MenuContainerViewController()
                menuContainerViewController.modalPresentationStyle = .fullScreen
                self.present(menuContainerViewController, animated: true, completion: nil)
            }
        }
    }

}
