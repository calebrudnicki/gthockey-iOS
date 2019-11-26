//
//  PreLaunchViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/13/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import RevealingSplashView

class PreLaunchViewController: UIViewController {

    // MARK: Properties

    private let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "BuzzOnlyLogo")!, iconInitialSize: CGSize(width: 124.0, height: 124.0), backgroundColor: .techNavy)

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .techNavy
        view.addSubview(revealingSplashView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLoginStatus()
    }

    // MARK: Status Functions

    private func checkLoginStatus() {
        guard
            let email = UserDefaults.standard.string(forKey: "email"),
            let password = UserDefaults.standard.string(forKey: "password")
        else {
            // User has no defaults, open welcome screen
            let welcomeViewController = WelcomeViewController()
            welcomeViewController.modalPresentationStyle = .fullScreen
            welcomeViewController.modalTransitionStyle = .crossDissolve
            revealingSplashView.startAnimation({
                self.present(welcomeViewController, animated: true, completion: nil)
            })
            return
        }

        let authentificator = Authentificator()
        authentificator.login(with: email, password, nil, nil) { result, error in
            if result {
                let menuContainerViewController = MenuContainerViewController()
                menuContainerViewController.modalPresentationStyle = .fullScreen
                menuContainerViewController.modalTransitionStyle = .crossDissolve
                self.revealingSplashView.startAnimation({
                    self.present(menuContainerViewController, animated: false, completion: nil)
                })
            } else {
                let alert = UIAlertController(title: "No internet connection",
                                              message: "\(error?.localizedDescription ?? "") Try restarting app when you have a connection.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    let menuContainerViewController = MenuContainerViewController()
                    menuContainerViewController.modalPresentationStyle = .fullScreen
                    menuContainerViewController.modalTransitionStyle = .crossDissolve
                    self.revealingSplashView.startAnimation({
                        self.present(menuContainerViewController, animated: false, completion: nil)
                    })
                })
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
