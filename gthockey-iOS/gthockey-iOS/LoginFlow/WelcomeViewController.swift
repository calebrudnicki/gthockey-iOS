//
//  WelcomeViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/3/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

//import UIKit
//import FirebaseAuth
//import FirebaseDynamicLinks
//
//class WelcomeViewController: UIViewController {
//
//    // MARK: Properties
//
//    private var firstName: String?
//    private var lastName: String?
//
//    private let logoImageView: UIImageView = {
//        let logoImage = UIImage(named: "BuzzOnlyLogo")
//        let logoImageView = UIImageView(image: logoImage)
//        logoImageView.contentMode = .scaleAspectFit
//        logoImageView.clipsToBounds = true
//        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//        return logoImageView
//    }()
//
//    private let welcomeButtonsView = WelcomeButtonsView()
//    private let signupView = SignupView()
//    private let loginView = LoginView()
//
//    // MARK: Init
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .techNavy
//        
//        welcomeButtonsView.delegate = self
//
//        signupView.delegate = self
//        signupView.isHidden = true
//        signupView.alpha = 0.0
//
//        loginView.delegate = self
//        loginView.isHidden = true
//        loginView.alpha = 0.0
//
//        view.addSubviews([logoImageView, welcomeButtonsView, signupView, loginView])
//        updateViewConstraints()
//    }
//
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//
//        NSLayoutConstraint.activate([
//            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 128.0),
//            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
//            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            signupView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
//            signupView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
//            signupView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0)
//        ])
//
//        NSLayoutConstraint.activate([
//            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
//            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
//            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
//        ])
//
//        NSLayoutConstraint.activate([
//            welcomeButtonsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
//            welcomeButtonsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
//            welcomeButtonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0)
//        ])
//    }
//}
//
//extension WelcomeViewController: WelcomeButtonsViewDelegate {
//
//    // MARK: WelcomeButtonsViewDelegate
//
//    func didTapSignupButton() {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.welcomeButtonsView.alpha = 0.0
//            self.signupView.alpha = 1.0
//        }, completion: { _ in
//            self.welcomeButtonsView.isHidden = true
//            self.signupView.isHidden = false
//        })
//    }
//
//    func didTapLoginButton() {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.welcomeButtonsView.alpha = 0.0
//            self.loginView.alpha = 1.0
//        }, completion: { _ in
//            self.welcomeButtonsView.isHidden = true
//            self.loginView.isHidden = false
//        })
//    }
//
//}
//
//extension WelcomeViewController: SignupViewDelegate {
//
//    // MARK: SignUpViewDelegate
//
//    func didTapSignupButton(with firstName: String, _ lastName: String, _ email: String, _ password: String, _ signupButton: PillButton) {
//        self.firstName = firstName
//        self.lastName = lastName
//
//        AuthenticationManager().createUser(with: firstName, lastName, email, password) { result, error in
//            if result {
//                self.switchToLogin(with: email, password: password)
//                signupButton.isLoading = false
//            } else {
//                let alert = UIAlertController(title: "Sign up failed",
//                                          message: error?.localizedDescription,
//                                          preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
//                    signupButton.isLoading = false
//                }))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
//
//    func switchToLogin(with email: String?, password: String?) {
//
//        UIView.animate(withDuration: 0.5, animations: {
//            self.signupView.alpha = 0.0
//            self.loginView.alpha = 1.0
//        }, completion: { _ in
//            self.signupView.isHidden = true
//            self.loginView.isHidden = false
//        })
//
//        if let email = email, let password = password {
//            loginView.setFields(with: email, password: password)
//
//            let alert = UIAlertController(title: "Check your email to verify your account before continuing",
//                                          message: "You should have received an email from firebase@gthockey-ios.firebase.com.",
//                                          preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default))
//            alert.addAction(UIAlertAction(title: "Open email", style: .default, handler: { action in
//                let mailURL = URL(string: "message://")!
//                if UIApplication.shared.canOpenURL(mailURL) {
//                    UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
//                }
//            }))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
//
//}
//
//extension WelcomeViewController: LoginViewDelegate {
//
//    // MARK: LoginViewDelegate
//
//    func didTapLoginButton(with email: String, _ password: String, _ loginButton: PillButton) {
//        let actionCodeSettings = ActionCodeSettings()
//        actionCodeSettings.handleCodeInApp = true
//        actionCodeSettings.url = URL(string: String(format: "https://gthockey-ios.firebaseapp.com/?email=%@", email))
//        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
//
//        AuthenticationManager().sendSignInLink(to: email, with: actionCodeSettings, { error in
//            if let error = error {
//                //Could not send sign in email
//                let errorAlert = UIAlertController(title: "Could not send email",
//                                                   message: "Error was found. \(error).",
//                                                   preferredStyle: .alert)
//                errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
//                self.present(errorAlert, animated: true, completion: nil)
//            }
//
//            let successAlert = UIAlertController(title: "Verification email has been sent",
//                                                 message: "An email has been sent to \(email). Use the link found in the email to complete the sign in process.",
//                                                 preferredStyle: .alert)
//            successAlert.addAction(UIAlertAction(title: "Ok", style: .default))
//            successAlert.addAction(UIAlertAction(title: "Open email", style: .default, handler: { action in
//                let mailURL = URL(string: "message://")!
//                if UIApplication.shared.canOpenURL(mailURL) {
//                    UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
//                }
//            }))
//            self.present(successAlert, animated: true, completion: nil)
//        })
//
//
//        UserDefaults.standard.set(email, forKey: "Email")
//    }
//
//    func didTapFinalLoginButton(with email: String, _ finalLoginButton: PillButton) {
//        if let link = UserDefaults.standard.value(forKey: "link") as? String {
//            Auth.auth().signIn(withEmail: email, link: link, completion: { result, error in
//                if error == nil && result != nil {
//                    if (Auth.auth().currentUser?.isEmailVerified)! {
//                        print("user verified")
//                        let menuContainerViewController = MenuContainerViewController()
//                        menuContainerViewController.modalPresentationStyle = .fullScreen
//                        self.present(menuContainerViewController, animated: true, completion: nil)
//                    } else {
//                        //tell user to verify email
//                    }
//                }
//            })
//        }
//    }
//
//    func switchToSignup() {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.loginView.alpha = 0.0
//            self.signupView.alpha = 1.0
//        }, completion: { _ in
//            self.loginView.isHidden = true
//            self.signupView.isHidden = false
//        })
//    }
//
//    func forgotPassword(with email: String) {
//        AuthenticationManager().resetPassword(with: email, completion: { error in
//            if error != nil {
//                let alert = UIAlertController(title: "Could not initiate password reset",
//                                              message: error?.localizedDescription,
//                                              preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                self.present(alert, animated: true, completion: nil)
//            } else {
//                let alert = UIAlertController(title: "Check your email",
//                                              message: "A password reset link should be in your \(email) email",
//                                              preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                alert.addAction(UIAlertAction(title: "Open email", style: .default, handler: { action in
//                    let mailURL = URL(string: "message://")!
//                    if UIApplication.shared.canOpenURL(mailURL) {
//                        UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
//                     }
//                }))
//                self.present(alert, animated: true, completion: nil)
//            }
//        })
//    }
//
//    func promptUserForValidEmail() {
//        let alert = UIAlertController(title: "Not a valid email address",
//                                      message: "Please enter a valid email address to reset your password",
//                                      preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default))
//        self.present(alert, animated: true, completion: nil)
//    }
//
//}
